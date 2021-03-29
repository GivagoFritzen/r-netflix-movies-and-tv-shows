path = ''
fileName = 'netflix_titles.csv'

pathAndFileName = paste(path, fileName,sep="")
bd<-read.csv(pathAndFileName)

#Visualizando a base de dados:
View(bd)

#----------- Pegar todos Dados (e filtrar) ---------------------

# Ratings
ratings = table(unlist(strsplit(tolower(bd$rating), " ")))

#---------------------------------------------------------------

# Release Year
release_year = table(unlist(strsplit(tolower(bd$release_year), " ")))

#---------------------------------------------------------------

# Paises
countOfType = table(bd$type)
pie(countOfType)

# Obteve valores errados, devido virgula
table(unlist(strsplit(tolower(bd$country), " ")))

# Irei limpar os paises com virgula
# Pegar Paises
countries <- bd$country
length(countries)

countries <- Filter(function(x)!all(is.na(x) || is.null(x) || x == "" || x == 0), countries)
length(countries)

contriesWithComma = grep(',', countries, value=TRUE)
length(contriesWithComma)

newList <- vector(mode = "list", length = 0)
length(newList)

for (row in contriesWithComma){
  separeteComma = unlist(strsplit(row, ","))
  removeSpaces = gsub(" ", "", separeteComma, fixed = TRUE)
  newList <- append(newList, removeSpaces)
}

contriesWithOutComma = countries[!grepl(",",unlist(countries))]
length(contriesWithOutComma)

totalContries <- append(contriesWithOutComma, newList)
contries = table(unlist(strsplit(tolower(totalContries), " ")))

#---------------------------------------------------------------

listed_in <- bd$listed_in
length(listed_in)
categories =table(unlist(strsplit(tolower(listed_in), ",")))

#---------------------------------------------------------------

#----------------- Visualizar dados ---------------------------
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("hrbrthemes")

library(ggplot2)
library(tidyverse)
library(hrbrthemes)

barplot(ratings)
barplot(release_year)
barplot(categories)
barplot(contries)
