# https://github.com/akshay-babbar/hierarchical-tsForecasting/blob/master/htsWebPage%5Brmd2r%5D.R
# https://medium.com/brillio-data-science/forecasting-hierarchical-time-series-using-r-598828dba435
# https://github.com/SrihariPramod/R_vs_Python_Cheatsheet/blob/master/R_vs_Python.pdf

require(plotly)	
require(fpp)	# contains vn dataset
require(ggplot2)	
library(hts)	
knitr::opts_chunk$set(echo = TRUE)	

#loading the data
temp <- knitr::kable(head(data.frame(vn,row.names = time(vn))))	# making table from the vn dataset
temp

#plotting the data
ggplotly(autoplot(vn,ylab='No of vistor Nights',title="a")) # plotting the dataset

# defining a hts model with 3 levels with 4 nodes in the middle and 8 nodes in bottom most level
y <- hts(vn, nodes=list(4,c(2,2,2,2)))
y

#making forecasts across all levels in the hierarchy using top-down forecast proportions
allf <- forecast(y, h=24,method = 'tdfp',fmethod = 'ets')	
names(allf$labels)=c('Pan Australia level Forecast','State Level Forecast',	
                     'City Level Forecast')#here tdfp means top-down forecast #proportions	
plot(allf)	

