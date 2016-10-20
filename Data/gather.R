#######################################################################################
#  This file is gather.R
#      The purpose is to load and clean up the si data frame by changing name cases
#         and data types as well as creating a new dataframe (si.sale) with the non-zero,
#         non-null sale price observations.
########################################################################################

# Set the directory
#setwd("C:/Users/Brian/Desktop/SMU/MSDS-6306-Doing-Data-Science/Unit-6/LiveSession6Assignment/FromBrianGobran/StatenIslandHousing")

# Load the csv file into a data frame
si <- read.csv("data/rollingsales_statenisland.csv", header=TRUE)

# Install (commented out) and load the packages we will need
install.packages("gdata")
install.packages("plyr")
library(gdata)
library(plyr)

# Let's see what is in the data frame
head(si)
summary(si)
str(si)

## Cleaning Data Step ##
########################
# Let's work on the sale price data first
#   If the first character is a number, replace it with a blank
#   Create a numeric (.N) sale price variable
#   Determine the number of NA sales prices
si$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", si$SALE.PRICE))
missingPrices <- count(is.na(si$SALE.PRICE.N))
message("The number of missing sales prices is     ",missingPrices[2,2])
message("The number of non-missing sales prices is ",missingPrices[1,2])

# Change all the variable names to lower case
names(si) <- tolower(names(si))

# Let's work on the square footage data
#   If the first character is a number, replace it with a blank
#   Convert to numeric
si$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", si$gross.square.feet))
si$land.sqft <- as.numeric(gsub("[^[:digit:]]","", si$land.square.feet))

# Convert the year built to numeric also
si$year.built <- as.numeric(as.character(si$year.built))

# Check the sales price data with a histogram
hist(si$sale.price.n)

# Makes a copy of the data si where observations are replaced with NA if there is an NA in sale.price.n column
# New data frame called si.sale
si.sale <- si[si$sale.price.n!=0,]

# Copy si.sale data frame excluding null sale prices into a new data frame si.sale.nonull
si.sale.nonull <- si.sale[(!is.na(si.sale$sale.price.n)),]

# Copy si.sale.null data frame excluding null in gross.sqft into a new data frame si.sale.sqft.nonull
si.sale.sqft.nonull <- si.sale[(!is.na(si.sale$gross.sqft)),]

