library(tidyverse)

set.seed(20191014)
diamonds = sample_n(ggplot2::diamonds, 1000)
diamonds

## Example 1

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()

ggplot(data = diamonds, aes(x = carat, y = price))

ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.25, color = "black", size=0.2)

## Example 4

ggplot(data = diamonds, aes(y=price, x=1)) +
  geom_boxplot()

ggplot(data = diamonds, aes(y=price, x=cut)) +
  geom_boxplot()

ggplot(data = diamonds, aes(y=price, x=cut, color=color)) +
  geom_boxplot()

ggplot(data = diamonds, aes(y=price, x=cut, fill=color)) +
  geom_boxplot()


## Example 5

ggplot(diamonds, aes(y=cut, color=color)) +
  geom_bar()

ggplot(diamonds, aes(x=cut, fill=color)) +
  geom_bar(pos="dodge") +
  coord_flip()


ggplot(data = diamonds, aes(x = cut, fill=color)) +
  geom_bar(position = "dodge", color = "black") +
  coord_flip() +
  scale_fill_brewer(palette = "Reds")

## Exercise 1

ggplot(diamonds, aes(x=carat, y=price, color=cut)) +
  geom_point()

ggplot(diamonds, aes(x=carat, y=price, color=cut)) +
  geom_point() +
  scale_y_log10()

diamonds %>%
  filter(carat < 4) %>%
  ggplot(aes(x=carat, y=price, color=cut)) +
    geom_point() +
    scale_y_log10() +
    geom_smooth()

diamonds %>%
  filter(carat < 4) %>%
  ggplot(aes(x=carat, y=price, color=cut)) +
  geom_point() +
  scale_y_log10() +
  geom_smooth(color = "black", se=FALSE, fullrange=TRUE)

diamonds %>%
  filter(carat < 4) %>%
  ggplot(aes(x=carat, y=price)) +
  geom_point(aes(color=cut)) +
  scale_y_log10() +
  geom_smooth(color="black", se=FALSE, fullrange=TRUE)



## Exercise 2

ggplot(diamonds, aes(x=clarity, fill=color)) +
  geom_bar(color="black") +
  facet_wrap(vars(cut)) +
  coord_flip() +
  scale_fill_brewer("blues")
