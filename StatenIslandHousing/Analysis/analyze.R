#######################################################################################
#
#  This file is analyze.R
#      The purpose is to take the gather.R results (si.sale) and nterpret the square
#          footage and sale price data for family homes
#
#######################################################################################

#
# Graph the square footage and sales price data on a Cartesian scale
#

plot(si.sale$gross.sqft,si.sale$sale.price.n)

#
# Due to the tight cluster of points and the few outliers,
#    Graph the square footage and sales price data on a log-log (base 10) scale
#

plot(log10(si.sale$gross.sqft),log10(si.sale$sale.price.n))


#
# We observe some extremely low prices and a cloud of data
# Let's separate the "family" building class into a new data frame (si.homes),
#    determine the size, and make the price-square footage graph again
#

si.homes <- si.sale[which(grepl("FAMILY",si.sale$building.class.category)),]
dim(si.homes)
message("The number of family homes with sale prices is ", nrow(si.homes))
plot(log10(si.homes$gross.sqft),log10(si.homes$sale.price.n))

#
# We still observe some extremely low prices and a cloud of data
#   If we look at homes that sold for less than $100,000, we find 176
#       with a mean of less than $23,000
#

summary(si.homes[which(si.homes$sale.price.n<100000),])

#
# Let's define as outliers homes selling for less than $100,000
#   and remove them from our si.homes data frame
#   We'll include in the outliers homes with less than 100 sq ft
#

#BDG si.homes$outliers <- (log10(si.homes$sale.price.n) <=5 || (si.homes$gross.sqft < 100 )) + 0
si.homes$outliers <- log10(si.homes$sale.price.n) <=5  + 0
si.homes <- si.homes[which(si.homes$outliers==0),]

#
# Graph the results on log-log (base e to spread it out) and
# Cartesian coordinates
#

plot(log(si.homes$gross.sqft),log(si.homes$sale.price.n), xlim=range(5:10))

plot(si.homes$gross.sqft,si.homes$sale.price.n)















