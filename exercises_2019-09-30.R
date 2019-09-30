d= data.frame(a = 1:3, b = 3:1)
d[,-"b"]
d[,-2, drop=FALSE]

d %>% select(-b)

# Examples

library(dplyr)
library(nycflights13)

flights

# How many flights to Los Angeles (LAX) did each of the legacy carriers (AA, UA, DL or US)
# have in May from JFK, and what was their average duration?

flights %>%
  filter(dest == "LAX") %>%
  filter(carrier %in% c("AA", "UA", "DL", "US")) %>%
  filter(month == 5) %>%
  filter(origin == "JFK") %>%
  group_by(carrier) %>%
  summarise(n = n(), avg_dur = mean(air_time, na.rm=TRUE))


# select(flights, air_time > 100)

# What was the shortest flight out of each airport in terms of distance? In terms of duration?

flights %>%
  select(origin, dest, air_time, distance) %>%
  group_by(origin) %>%
  summarize(min_dist = min(distance))

flights %>%
  select(origin, dest, air_time, distance) %>%
  group_by(origin) %>%
  arrange(distance) %>%
  slice(1)

flights %>%
  select(origin, dest, air_time, distance) %>%
  group_by(origin) %>%
  filter(distance == min(distance, na.rm = TRUE))

flights %>%
  select(origin, dest, air_time, distance) %>%
  group_by(origin) %>%
  filter(distance == min(distance, na.rm = TRUE)) %>%
  group_by(origin, dest) %>%
  summarize(n = n(), distance = distance[1])


# Exercise 1

## Which plane (check the tail number) flew out of each New York airport the most?

flights %>%
  select(origin, tailnum) %>%
  count(origin, tailnum) %>%
  group_by(origin) %>%
  filter(!is.na(tailnum)) %>%
  filter(n == max(n))

## Which date should you fly on if you want to have the lowest possible average departure
## delay? What about arrival delay? By origin airport

flights %>%
  mutate(date = paste(year, month, day, sep="/")) %>%
  select(origin, dep_delay, date) %>%
  group_by(origin, date) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(avg_dep_delay) %>%
  filter(avg_dep_delay == min(avg_dep_delay))

