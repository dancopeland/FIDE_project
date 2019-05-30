# library(rvest)
# url <- "http://ratings.fide.com/download.phtml"
# 
# webpage <- read_html(url)

FIDE <- read.csv("players_list_foa.csv", header = TRUE)

str(FIDE)

head(FIDE)
FIDE <- FIDE[-1,] # removed bad column
head(FIDE)

# clean ratings columns


# remove players who do not have any ratings






