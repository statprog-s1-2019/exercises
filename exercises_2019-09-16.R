#Exercise 1

## Part 1

typeof( c(1, NA+1L, "C") )
# Character

typeof( c(1L / 0L, NA) )
# Double"

typeof( c(1:3, 5) )
# Double

typeof( c(3L, NaN+1L) )
# Double

typeof( c(NA, TRUE) )
# Logical


## Part 2

# Logical < Integer < Double < Character


# Coercion example

r = rnorm(1000)
head(r > 0)
length(r > 0)

sum(r > 0)


# seq_along

x = 1:10
x = integer()

# Bad - fragile
for(y in 1:length(x)) {
  print(y)
}


1:length(x)
1:0

# Good - robust
for(y in seq_along(x)) {
  print(y)
}




