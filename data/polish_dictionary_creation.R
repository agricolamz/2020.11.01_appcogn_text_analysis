setwd("/home/agricolamz/work/materials/2020.02_Naumburg_seminar/naumburg_course/data")
library(tidyverse)
pl <- read_lines("/home/agricolamz/books/languages/Eurasia/Indo-European/Balto-Slavic/Slavic/Polish/Slowniki/sjp-odm-20200205/odm.txt")
pl %>% 
  map_chr(function(x){first(str_split(x, ",", simplify = TRUE))}) %>% 
  tibble(word = .) ->
  dict

dict %>% 
  filter(!str_detect(word, " |\\.|-|[0-9]"),
         word != str_to_upper(word),
         word != str_to_sentence(word)) %>% 
  mutate(n_char = str_length(word),
         word2 = str_replace(word, "i([aeyioąęóu])", "\\1"),
         n_vowels = str_count(word2, "[aeyioąęóu]")) %>% 
  select(-word2) %>% 
  write_csv("polish_dictionary.csv")

