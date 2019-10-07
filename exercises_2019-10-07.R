library(tidyverse)

## Example 1

(grades = tibble(
  name  = c("Alice", "Bob", "Carol", "Dave"),
  hw_1   = c(19, 18, 18, 19),
  hw_2   = c(19, 20, 20, 19),
  hw_3   = c(18, 18, 18, 18),
  hw_4   = c(20, 16, 17, 19),
  exam_1 = c(89, 77, 96, 86),
  exam_2 = c(95, 88, 99, 82)
))

grades %>%
  mutate(
    hw_total = (hw_1 + hw_2 + hw_3 + hw_4)/80,
    exam_total = (exam_1 + exam_2) / 200,
    overall = 0.6 * hw_total + 0.4 * exam_total
  )


grades$hw_5 = rep(20, 4)
grades

grades %>%
  mutate(
    hw_total = (hw_1 + hw_2 + hw_3 + hw_4 + hw_5)/100,
    exam_total = (exam_1 + exam_2) / 200,
    overall = 0.6 * hw_total + 0.4 * exam_total
  )


## Tidier

grades %>%
  pivot_longer(cols = -name, names_to = "assignment", values_to = "score")

grades %>%
  pivot_longer(cols = -name, names_to = "assignment", values_to = "score") %>%
  separate(assignment, into = c("type","id"), sep = "_")

grades %>%
  pivot_longer(
    cols = -name, names_to = c("type","id"),
    values_to = "score", names_sep = "_"
  ) %>%
  group_by(name, type) %>%
  summarize(total_score = sum(score))

grades$exam_3 = rep(94, 4)

grades %>%
  pivot_longer(
    cols = -name, names_to = c("type","id"),
    values_to = "score", names_sep = "_"
  ) %>%
  group_by(name, type) %>%
  summarize(total_score = sum(score)) %>%
  pivot_wider(id_cols = name, names_from = type, values_from = total_score) %>%
  mutate(
    overall = 0.6*hw/100 + 0.4*exam/300
  )

## Exercise 1

library(repurrrsive)

View(repurrrsive::sw_people)

char_names = c()
for(char in repurrrsive::sw_people) {
  char_names = c(char_names, char$name)
}
char_names



char_names = rep(NA, length(sw_people))
for(i in seq_along(sw_people)) {
  char_names[i] = sw_people[[i]]$name
}
char_names


sapply(sw_people, function(char) char$name)

lapply(sw_people, function(char) char$name) %>% unlist()


x = list(list(a=1L,b=2L,c=list(d=3L,e=4L)),
         list(a=5L,b=6L,c=list(d=7L,e=8L,f=9L)))

map_chr(x, list(3,"d"))

map_chr(x, c(3,"d"))

map_int(x, c("c", "f"))

map_int(x, c("c", "f"), .default = NA)
map_int(x, c("c", "f"), .default = -999L)

## Exercise 2

names(sw_people[[1]])

tibble(
  name = map_chr(sw_people, "name"),
  height = map_chr(sw_people, "height") %>%
    ifelse(. == "unknown", NA, .) %>%
    as.integer(),
  mass = map_chr(sw_people, "mass") %>%
    stringr::str_replace(",","") %>%
    ifelse(. == "unknown", NA, .) %>%
    as.integer()
)

as.numeric("1,358")

clean_int_data = function(c) {
  c %>%
    stringr::str_replace(",","") %>%
    ifelse(. == "unknown", NA, .) %>%
    as.integer()
}

d = tibble(
  name = map_chr(sw_people, "name"),
  height = map_chr(sw_people, "height") %>% clean_int_data(),
  mass = map_chr(sw_people, "mass") %>% clean_int_data(),
  starships = map(sw_people, "starships")
)

d %>%
  mutate(
    n_starships = map_int(starships, length)
  )
