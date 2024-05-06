# --------------------------------------------------------------------------------------------
# Example function

g <- function(s, n) {
  x <- z <- 5
  d
  for (j in 1:n) {
    print(s)
  }
  ggplot() + geom_point()
  for( i in 1:2) {} 
  print(y)
  print(zz)
}

e <- new.env(parent = globalenv())
e$y <- "Hello from the new environment"
e$zz <- "Hello from the new environment2"
environment(g) <- e
e2 <- new.env(parent = globalenv())
e2$x <- "Hello from the new environment"
e2$x1 <- "Hello from the new environment222"
e2$zz <- "Hello from the new environment2"
environment(g) <- e2

# --------------------------------------------------------------------------------------------
# listSymbols function implementation

listSymbols <- function(func) {
  # getting all the symbols from the function body
  symbols <- all.names(print(body(func)))
  allSymbols <- unique(symbols)
  
  # searching for loaded packages and their functions
  pkgs <- search()
  pkgs <- pkgs[grep("package:",pkgs)]
  loadedFunctions <- unlist(sapply(pkgs,lsf.str))
  
  # linking symbols from the function body to those in loaded packages
  symbolsInloadedFunctions <- allSymbols[allSymbols %in% loadedFunctions]
  
  tmp <- data.frame(sapply(symbolsInloadedFunctions, function(x) loadedFunctions[loadedFunctions==x]))
  tmp$definition <- rownames(tmp)
  rownames(tmp) <- 1:nrow(tmp)
  colnames(tmp) <- c("Symbol","Definition")
  
  tmp$Definition <- gsub(".*package:(.+?)\\d+","\\1",tmp$Definition)
  
  # searching for arguments
  if(length(formalArgs(func)) > 0) {
    tmp2 <- data.frame(Symbol = formalArgs(func), Definition = "arg")
    tmp <- rbind(tmp,tmp2)
  }
  
  # searching for locally defined variables
  if("<-" %in% symbols) {
    locallyDefinedSymbols <- symbols[which(symbols == "<-")+1]
    if(sum(locallyDefinedSymbols %in% tmp$Symbol) > 0) {
      locallyDefinedSymbols <- locallyDefinedSymbols[-which(locallyDefinedSymbols %in% tmp$Symbol)]
    }
    tmp3 <- data.frame(Symbol = locallyDefinedSymbols, Definition = "locally defined")
    tmp <- rbind(tmp,tmp3)
  }
  
  # searching for temporary symbols
  if("for" %in% symbols) {
    tempSymbols <- symbols[which(symbols == "for")+1]
    if(sum(tempSymbols %in% tmp$Symbol) > 0) {
      tempSymbols <- tempSymbols[-which(tempSymbols %in% tmp$Symbol)]
    }
    tmp4 <- data.frame(Symbol = tempSymbols, Definition = "temp symbol")
    tmp <- rbind(tmp,tmp4)
  }

  # searching for environment variables and others
  if(sum(!allSymbols %in% tmp$Symbol) > 0) {
    envirs <- ls(envir = .GlobalEnv)[sapply(ls(envir = .GlobalEnv), function(x) is.environment(get(x)))]
    envirs <- lapply(envirs, function(x) get(x))
    
    if(length(envirs)>0) {
      getEnvs <- function(s) Filter(function(e) s %in% ls(e), envirs) |>
        sapply(capture.output) |>
        toString()
      
      if(sum(sapply(allSymbols[!allSymbols %in% tmp$Symbol], getEnvs) != "") > 0) {
        tmp5 <- data.frame(Symbol = allSymbols[!allSymbols %in% tmp$Symbol], Definition = sapply(allSymbols[!allSymbols %in% tmp$Symbol], getEnvs))
        tmp5$Definition <- ifelse(tmp5$Definition=="","can't find definition",tmp5$Definition) 
        tmp <- rbind(tmp, tmp5)
        rownames(tmp) <- 1:nrow(tmp)
      }
      else {
        tmp5 <- data.frame(Symbol = allSymbols[!allSymbols %in% tmp$Symbol], Definition = "can't find definition")
        tmp <- rbind(tmp, tmp5)
      }
    }
    else {
    tmp6 <- data.frame(Symbol = allSymbols[!allSymbols %in% tmp$Symbol], Definition = "can't find definition")
    tmp <- rbind(tmp, tmp6)
    }
  }
  shell("cls")
  return(tmp)
}

listSymbols(g)

