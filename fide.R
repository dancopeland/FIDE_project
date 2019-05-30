# library(rvest)
# url <- "http://ratings.fide.com/download.phtml"
# 
# webpage <- read_html(url)

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

SR_bool <- FIDE$SRting == " "
head(SR_bool)

# clean ratings columns



