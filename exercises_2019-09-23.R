# Examples

x = 1:3
names(x) = c(TRUE, FALSE, TRUE)

x

x["TRUE"]
x["TRU"]

x[[c(TRUE,FALSE)]]

x[[]]
x[[0]]
x[[-1]]



x = data.frame(x = 1:3, y=c("A","B","C"))

x[,1]
x[,c(1,1)]

x[1,]
x[1:2,]

x[1,,drop=TRUE]
x[1:2,,drop=TRUE]


# Exercise 1

x = c(56, 3, 17, 2, 4, 9, 6, 5, 19, 5, 2, 3, 5, 0, 13, 12, 6, 31, 10, 21, 8, 4, 1, 1, 2, 5, 16, 1, 3, 8, 1,
      3, 4, 8, 5, 2, 8, 6, 18, 40, 10, 20, 1, 27, 2, 11, 14, 5, 7, 0, 3, 0, 7, 0, 8, 10, 10, 12, 8, 82,
      21, 3, 34, 55, 18, 2, 9, 29, 1, 4, 7, 14, 7, 1, 2, 7, 4, 74, 5, 0, 3, 13, 2, 8, 1, 6, 13, 7, 1, 10,
      5, 2, 4, 4, 14, 15, 4, 17, 1, 9)


## Select every third value starting at position 2 in x.

### Pos Int Subsetting
x[ seq(2, length(x), by=3) ]

### Logical Subsetting
x[ c(FALSE, TRUE, FALSE) ]


## Remove all values with an odd index (e.g. 1, 3, etc.)

### Logical subsetting
x[ seq_along(x) %% 2 != 1 ]

### Pos Int Subsetting
x[ seq(2, length(x), by=2) ]


## Remove every 4th value, but only if it is odd.

x[ c(TRUE, TRUE, TRUE, FALSE) | x %% 2 == 0 ]



# Exercise 2

d = data.frame(
  patient_id = c(1, 2, 3, 4, 5),
  age = c(32, 27, 56, 19, 65),
  bp = c(110, 100, 125, -999, -999),
  o2 = c(97, 95, -999, -999, 99)
)

## Task 1 - using the subsetting tools we've discussed come up with code that will replace the -999 values
##          in the bp and o2 column with actual NA values. Save this as d_na.

d_na = d
d_na$bp[d_na$bp == -999] = NA
d_na$o2[d_na$o2 == -999] = NA

d_na

## Task 2 - Once you have created d_na come up with code that translate it back into the original data frame d,
##          i.e. replace the NAs with -999.

d2 = d_na
d2$bp[is.na(d2$bp)] = -999
d2$o2[is.na(d2$o2)] = -999

d2

identical(d2,d)

