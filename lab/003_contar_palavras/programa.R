
library(stringr)

folder <- "~/git/lincom"
corpus <- paste(folder, "corpora/noticias", sep = "/")
output <- paste(folder, "resultado.csv", sep = "/")

x <- 0
y <- 0

df <- data.frame(
  Site <- character(),
  Page <- character(),
  Word <- character(),
  Freq <- numeric()
)

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
    
    for (l in ll) {
      ww <- c(ww, l)
    }
    
    ww <- sort(ww)
    uu <- unique(ww)
    freq <- rep(0, length(uu))
    names(freq) <- uu
    
    for (w in ww) {
        freq[w] <- freq[w] + 1
    }
    
    Site <- paste("site", x)
    Page <- paste("page", y)
    Word <- names(freq)
    Freq <- unname(freq)
    xx <- data.frame(Site, Page, Word, Freq)
     
    df <- rbind(df, xx)
  }
}

write.csv(df, file=output, row.names = FALSE, fileEncoding = "UTF-8")



