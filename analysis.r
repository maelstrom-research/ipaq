df_test <- data.frame(x = rnorm(10), y = rbinom(10, 1, .5))

adder <- function(df) {
  out <- df[,1] + df[,2]
  out
}

y <- adder(df_test)
