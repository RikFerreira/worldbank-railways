library(tidyverse)
library(wbstats)

cache <- wb_cache()

wb_search("transp") %>% View

railways_goods <- wb_data("IS.RRS.GOOD.MT.K6", mrnev = 1)
railways_people <- wb_data("IS.RRS.PASG.KM", mrnev = 1)

railways_goods %>%
  arrange(-IS.RRS.GOOD.MT.K6)

railways_people %>%
  arrange(-IS.RRS.PASG.KM)

railways_goods %>%
  mutate(
    iso3c = as_factor(iso3c) %>%
      fct_reorder(-IS.RRS.GOOD.MT.K6) %>%
      fct_lump(5, w = IS.RRS.GOOD.MT.K6)
  ) %>%
  ggplot() +
  geom_col(aes(iso3c, IS.RRS.GOOD.MT.K6))