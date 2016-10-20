#######################################################################################
#  This file is analyze.R
#      The purpose is to take the gather.R results (si.sale) and interpret the square
#          footage and sale price data for family homes
#######################################################################################

# Graph the square footage and sales price data on a Cartesian scale
plot(si.sale.sqft.nonull$gross.sqft, si.sale.sqft.nonull$sale.price.n)

# Due to the tight cluster of points and the few outliers,
#    Graph the square footage and sales price data on a log-log (base 10) scale
plot(log10(si.sale.sqft.nonull$gross.sqft),log10(si.sale.sqft.nonull$sale.price.n))

# We observe some extremely low prices and a cloud of data
# Let's separate the "family" building class into a new data frame (si.homes),
#    determine the size, and make the price-square footage graph again
si.homes <- si.sale.sqft.nonull[which(grepl("FAMILY",si.sale.sqft.nonull$building.class.category)),]
dim(si.homes)
message("The number of family homes with sale prices is ", nrow(si.homes))
plot(log10(si.homes$gross.sqft),log10(si.homes$sale.price.n))

# We still observe some extremely low prices and a cloud of data
#   If we look at homes that sold for less than $100,000, we find 176
#       with a mean of less than $23,000
summary(si.homes[which(si.homes$sale.price.n<100000),])

# Let's define as outliers homes selling for less than $100,000
#   and remove them from our si.homes data frame
#   We'll include in the outliers homes with less than 100 sq ft
si.homes$outliers <- log10(si.homes$sale.price.n) <=5  + 0
si.homes$outliers2 <- si.homes$gross.sqft < 100 + 0
si.homes <- si.homes[which(si.homes$outliers==0 & si.homes$outliers2==0),]

# Graph the results on log-log (base e to spread it out)
plot(log(si.homes$gross.sqft),log(si.homes$sale.price.n), xlim=range(5:10))

# Check cartesian coordinate scatter plot
plot(si.homes$gross.sqft,si.homes$sale.price.n)

# It's hard to tell if any patterns can be seen strictly from the cartesian coordinate scatter plot.
#   Delving further into the analysis, we create a scatter plot separating data by building.class
library(ggplot2)
ggplot(si.homes, aes(x=gross.sqft,y=sale.price.n))  + 
  geom_point(aes(colour=building.class.category), alpha = 0.3, size=3) +
  geom_smooth(se=FALSE, method = "lm")
  # From the scatter plot that is grouped by building category (ggplot function),
  # there appears to be differences in observation densities per building
  # category. 

# Due to overplotting of the data points, we separated out each building category groups 
# into it's own scatter plot.Next, we separate out each building.class.category to it's own scatter plot

# Change building.class.category to character
si.homes$building.class.category <- as.character(si.homes$building.class.category)
class(si.homes$building.class.category) # Checking building class variable changed class from factor to character 

# Create three separate data frames by building.class.category
si.homes.one <- si.homes[which(grepl("ONE", si.homes$building.class.category)),]
si.homes.two <- si.homes[which(grepl("TWO", si.homes$building.class.category)),]
si.homes.three <- si.homes[which(grepl("THREE", si.homes$building.class.category)),]

# Generate individual scatter plots by building.class.category
# One Family Dwellings, Two Family Dwellings, Three Family Dwellings
ggplot(si.homes.one, aes(x = gross.sqft,y = sale.price.n))  + 
  geom_point(alpha = 0.2, size=3) + geom_smooth(se = FALSE, method = "lm") +
  ggtitle("One Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Sale Price, [$]")

ggplot(si.homes.two, aes(x=gross.sqft,y=sale.price.n))  + 
  geom_point(alpha = 0.2, size=3)+ geom_smooth(se = FALSE, method = "lm") +
  ggtitle("Two Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Sale Price, [$]")

ggplot(si.homes.three, aes(x=gross.sqft,y=sale.price.n))  + 
  geom_point(alpha = 0.2, size=3) + geom_smooth(se = FALSE, method = "lm") +
  ggtitle("Three Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Sale Price, [$]")

# Calculating correlation coefficients per building.class.category
cor(si.homes.one$gross.sqft, si.homes.one$sale.price.n)
# Correlation coefficient = 0.69 for one family dwelling homes
cor(si.homes.two$gross.sqft, si.homes.two$sale.price.n)
# Correlation coefficient = 0.55 for two family dwelling homes
cor(si.homes.three$gross.sqft, si.homes.three$sale.price.n)
# Correlation coefficient = 0.625 for three family dwelling homes

# Change zip code column from numeric to character to use as the x-axis for box plots
si.homes.one$zip.code <- as.character(si.homes.one$zip.code)
si.homes.two$zip.code <- as.character(si.homes.two$zip.code)
si.homes.three$zip.code <- as.character(si.homes.three$zip.code)

# Histograms per building.class.category by zip code
ggplot(si.homes.one) + aes(x = zip.code, y = log10(sale.price.n)) + 
  stat_boxplot(geom='errorbar') + geom_boxplot() + 
  ggtitle("One Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Log10(Sale Price, [$])")
# Observations: Zip code 10309 has the highest mean sale price for one family dwelling homes.
# Observations: Zip code 10303 has the lowest mean sale price for one family dwelling homes.

ggplot(si.homes.two) + aes(x = zip.code, y = sale.price.n) +
  stat_boxplot(geom='errorbar') + geom_boxplot() + 
  ggtitle("Two Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Sale Price, [$]")
# Observations: Zip code 10307 has the highest mean sale price for two family dwelling homes.
# Observations: Zip code 10303 has the lowest mean sale price for two family dwelling homes.

ggplot(si.homes.three) + aes(x = zip.code, y = sale.price.n) +
  stat_boxplot(geom='errorbar') + geom_boxplot() + 
  ggtitle("Three Family Dwelling Homes") + 
  labs(x = "Gross Living Square Footage", y = "Sale Price, [$]")
# Observations: Zip code 10306 has the highest mean sale price for three family dwelling homes.
# Observations: Zip code 10302 has the lowest mean sale price for three family dwelling homes.











