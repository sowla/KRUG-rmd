library(dplyr)
library(lubridate)
library(countrycode)

hotels_orig <- 
  read.csv(
    "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv",
    stringsAsFactors = FALSE
  )

hotels_month <- 
  hotels_orig %>%
  filter(!(country %in% c("TMP", "NULL"))) %>%
  mutate(
    country = if_else(country == "CN", "CHN", country) %>%
      countrycode(origin = "iso3c", destination = "country.name"),
    arrival_ymd = paste(arrival_date_day_of_month, arrival_date_month, arrival_date_year) %>%
      dmy(),
    reservation_status_date = ymd(reservation_status_date),
    is_canceled = if_else(is_canceled == 1, TRUE, FALSE)
  ) %>% 
  select(
    hotel,
    is_canceled,
    lead_time,
    reservation_status_date,
    arrival_year = arrival_date_year,
    arrival_month = arrival_date_month,
    arrival_ymd,
    adr,
    meal,
    country,
    market_segment
  )

write.csv(hotels_month, "tidy_tues_hotels.csv", row.names = FALSE)