library(ggplot2)
library(dplyr)

# Read the data from csv as table then add the names of columns.
fuel_consumption <- read.table("bar-plot-fuel-consumptions/resources/fuel_consumption.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, fill = TRUE)
names(fuel_consumption) <- c("car", "mpg", "cyl")

# I'm specifying the order of x & y axis
fuel_consumption$cyl <- factor(fuel_consumption$cyl, levels = c(8, 6, 4))
fuel_consumption$car <- factor(fuel_consumption$car, levels = rev(fuel_consumption$car))

# Bar plot
ggplot(fuel_consumption, aes(x = mpg, y = car, fill = cyl)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = c("4" = "#a6cee3", "6" = "#1f78b4", "8" = "#b2df8a")) +
  labs(
    x = "Miles per gallon",
    y = NULL,
    fill = "Number of cylinders"
  ) +
  theme_minimal() +
  theme(legend.position = "top")