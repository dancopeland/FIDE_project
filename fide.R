# library(rvest)
# url <- "http://ratings.fide.com/download.phtml"
# 
# webpage <- read_html(url)

library("sjmisc")
library(stringr)
library(shiny)

FIDE <- read.csv("players_list_foa.csv", header = TRUE)

str(FIDE)

head(FIDE)
FIDE <- FIDE[-1,] # removed bad column
rownames(FIDE)<- NULL
head(FIDE,75)

# remove excess columns

FIDE$SGm <- NULL
FIDE$SK <- NULL
FIDE$RGm <- NULL
FIDE$Flag <- NULL

# change col names
colnames(FIDE)[colnames(FIDE) == "ID.Number"] <- "ID"
colnames(FIDE)[colnames(FIDE) == "Tit..WTit.OTit"] <- "Title"
colnames(FIDE)[colnames(FIDE) == "FOA.SRtng"] <- "SRting"
colnames(FIDE)[colnames(FIDE) == "B.day"] <- "Birth_year"
colnames(FIDE)[colnames(FIDE) == "RRtng"] <- "RRting"
colnames(FIDE)[colnames(FIDE) == "Rk.BRtng.BGm.BK"] <- "BRting"

# remove players who do not have any ratings

#create boolean matrix for each rating type, True means there is a rating. Add matrix together and apply to dataframe 

SR_bool <- NULL  # Check for blank
RR_bool <- NULL  # Check for NA
BR_bool <- NULL  # Check for blank
  
RR_bool <- !is.na(FIDE$RRting)
head(RR_bool)

SR_bool <- !apply(as.matrix(FIDE$SRting), 1, is_empty)
head(SR_bool, 20)

BR_bool <- !apply(as.matrix(FIDE$BRting), 1, is_empty)
head(BR_bool, 20)
head(FIDE,75)

rows_with_ratings <- BR_bool + RR_bool + SR_bool

head(rows_with_ratings, 20)

rows_with_ratings_T <- c(rows_with_ratings > 0)

head(rows_with_ratings_T, 20)

FIDE_rated <- FIDE[t(rows_with_ratings_T),]

head(FIDE_rated, 20)

rownames(FIDE_rated) <- NULL

FIDE$BRting <- as.character(FIDE$BRting)
FIDE$BRting <-  str_extract(FIDE$BRting,"\\d\\d\\d\\d")

FIDE$SRting <- as.numeric(as.character(FIDE$SRting))
FIDE$BRting <- as.numeric(as.character(FIDE$BRting))

FIDE_rated_SR <- FIDE[SR_bool,]
FIDE_rated_RR <- FIDE[RR_bool,]
FIDE_rated_BR <- FIDE[BR_bool,]

# clean BR ratings columns # only want number when partern ####

str(FIDE)

head(FIDE,50)

# remove birth year less people
head(FIDE_rated_SR,50)


# order by SR

FIDE_rated_SR_ordered <- FIDE_rated_SR[order(-FIDE_rated_SR$SRting),]

head(FIDE_rated_SR_ordered)
rownames(FIDE_rated_SR_ordered) <-NULL

# pull top 20
FIDE_rated_SR_top_20 <- FIDE_rated_SR_ordered[1:20,]

head(FIDE_rated_SR_top_20, 30)

# 

FIDE_rated_RR_top_20 <- 
FIDE_rated_BR_top_20 <- 


  # create a plot of the top ten "SRting" vs their "BRting"
  
# rewrite the script to take in multiple csv files, clean them (including sex column separation)

# create a shiny app that displays the changes in the top 10 players by "SRting" over time


