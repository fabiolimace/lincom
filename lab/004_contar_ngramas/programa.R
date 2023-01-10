
library(stringr)

folder <- "~/Desenvolvimento/git/lincom"
corpus <- paste(folder, "corpora/noticias", sep = "/")
output <- paste(folder, "resultado.csv", sep = "/")

x <- 0
y <- 0

Site <- character()
Page <- character()
Word <- character()
Freq <- numeric()

dd <- sort(list.dirs(corpus, full.names = TRUE))

for (d in dd) {
  
  if (basename(d) == basename(corpus)) {
    next # ignore the corpus base directory
  }
  
  x <- x + 1
  ff <- sort(list.files(d, include.dirs = FALSE, full.names = TRUE, pattern = "*.txt"))
  
  for (f in ff) {
    
    y <- y + 1
    ww <- character()
    ll <- str_extract_all(readLines(f, encoding = "UTF-8"), "[[:alpha:]]+")
    
    print(paste(x, y,f))
    
    for (l in ll) {
      ww <- c(ww, l)
    }
    
    # 2-gram matrix
    ng2a <- array(ww, dim = c(2, (length(ww) / 2L)))
    ng2b <- array(c(NA, ww), dim = c(2, ((length(ww) + 1) / 2L)))
    
    # 3-gram matrix
    ng3a <- array(ww, dim = c(3, (length(ww) / 3L)))
    ng3b <- array(c(NA, ww), dim = c(3, ((length(ww) + 1) / 3L)))
    ng3c <- array(c(NA, NA, ww), dim = c(3, ((length(ww) + 2) / 3L)))
    
    ww <- c(ww, 
            paste(ng2a[1,],ng2a[2,]),
            paste(ng2b[1,],ng2b[2,]),
            paste(ng3a[1,],ng3a[2,],ng3a[3,]),
            paste(ng3b[1,],ng3b[2,],ng3b[3,]),
            paste(ng3c[1,],ng3c[2,],ng3c[3,]))
    
    freq <- data.frame(table(ww))
    
    Site <- c(Site, rep(paste("site", x), length(freq$ww)))
    Page <- c(Page, rep(paste("page", y), length(freq$ww)))
    Word <- c(Word, as.character(freq$ww))
    Freq <- c(Freq, freq$Freq)
  }
}

df <- data.frame(Site, Page, Word, Freq)
write.csv(df, file=output, row.names = FALSE, fileEncoding = "UTF-8")



