# 

g <- function(s, n) {
  x <- y <- 5
  d
  for (j in 1:n) {
    print(s)
  }
  for( i in 1:2) {} 
}


listSymbols <- function(func) {
  symbols <- all.names(print(body(func)))
  allSymbols <- unique(symbols)
  
  pkgs <- search()
  pkgs <- pkgs[grep("package:",pkgs)]
  loadedPkgs <- unlist(sapply(pkgs,lsf.str))
  
  symbolsInLoadedPkgs <- allSymbols[allSymbols %in% loadedPkgs]
  otherSymbols <- allSymbols[!allSymbols %in% loadedPkgs]
  
  tmp <- data.frame(sapply(symbolsInLoadedPkgs, function(x) loadedPkgs[loadedPkgs==x]))
  tmp$definition <- rownames(tmp)
  rownames(tmp) <- 1:nrow(tmp)
  colnames(tmp) <- c("symbol","definition")
  
  tmp$definition <- gsub(".*package:(.+?)\\d+","\\1",tmp$definition)
  
  if(length(formalArgs(func)) > 0) {
    tmp2 <- data.frame(symbol = formalArgs(func), definition = "arg")
    tmp <- rbind(tmp,tmp2)
  }
  
  if("<-" %in% symbols) {
    locallyDefinedSymbols <- symbols[which(symbols == "<-")+1]
    if(sum(locallyDefinedSymbols %in% tmp$symbol) > 0) {
      locallyDefinedSymbols <- locallyDefinedSymbols[-which(locallyDefinedSymbols %in% tmp$symbol)]
    }
    tmp3 <- data.frame(symbol = locallyDefinedSymbols, definition = "locally defined")
    tmp <- rbind(tmp,tmp3)
  }
  
  if("for" %in% symbols) {
    tempSymbols <- symbols[which(symbols == "for")+1]
    if(sum(tempSymbols %in% tmp$symbol) > 0) {
      tempSymbols <- tempSymbols[-which(tempSymbols %in% tmp$symbol)]
    }
    tmp4 <- data.frame(symbol = tempSymbols, definition = "temp symbol")
    tmp <- rbind(tmp,tmp4)
  }
  
  if(sum(!allSymbols %in% tmp$symbol) > 0) {
    tmp5 <- data.frame(symbol = allSymbols[!allSymbols %in% tmp$symbol], definition = "can't find definition")
    tmp <- rbind(tmp, tmp5)
  }
  shell("cls")
  return(tmp)
}

listSymbols(g)
