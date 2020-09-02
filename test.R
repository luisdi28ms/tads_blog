library(tidyverse)
library(tidytext)
library(wordcloud2)
library(tvthemes)


#Load Data
tuesdata <- tidytuesdayR::tt_load('2020-08-11')
avatar <- tuesdata$avatar

#Prepare words by character
#characters <- c("Aang","Katara", "Sokka", "Zuko")
words <- avatar %>%
  select(character,character_words) %>%
  #filter(character %in% characters) %>%
  unnest_tokens(word,character_words) %>%
  anti_join(stop_words) %>%
  filter(!(word %in% c("hey","yeah")))

# Aang word cloud
cols <- avatar_pal(palette = "AirNomads",n = 7)
aang_words <- words %>%
  filter(character == "Aang") %>%
  count(word) %>%
  arrange(desc(n)) %>%
  filter(n > 1) %>%
  rename(freq = n) 

wordcloud2(aang_words,figPath = "images/aang.png",size = 1.3,
           color = rep(cols(7),nrow(aang_words)),backgroundColor = "#ece5d3")
