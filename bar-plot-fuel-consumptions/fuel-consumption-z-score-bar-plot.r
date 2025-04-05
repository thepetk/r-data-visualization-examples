library(ggplot2)
library(dplyr)

fuel_consumption <- read.table("bar-plot-fuel-consumptions/resources/fuel_consumption.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, fill = TRUE)
names(fuel_consumption) <- c("car", "mpg", "cyl")

# Adding the zscore column based on the formula provided
fuel_consumption$zscore <- (fuel_consumption$mpg - mean(fuel_consumption$mpg)) / sd(fuel_consumption$mpg)

# I'm creating a new variable to specify a class LOW & HIGH
fuel_consumption$mpg_group <- ifelse(fuel_consumption$zscore < 0, "LOW", "HIGH")
fuel_consumption$mpg_group <- factor(fuel_consumption$mpg_group, levels = c("LOW", "HIGH"))

# A new reordering is applied based on mpg
fuel_consumption$car <- reorder(fuel_consumption$car, desc(fuel_consumption$mpg))

# FIXME: Here I cannot apply the two groups low and high.
ggplot(fuel_consumption, aes(x = zscore, y = car, fill = zscore)) +
  geom_col(width = 0.7) +
  scale_fill_gradientn(
    colors = c("#2b2b7b", "#b1b1cc", "#fff2af", "#ffdf80"),
    values = scales::rescale(c(min(fuel_consumption$zscore), 0, max(fuel_consumption$zscore))), 
    name = "Z-Score"
  ) +
  labs(
    x = "Z-Score",
    y = NULL,
    fill = "MPG Group"
  ) +
  theme_minimal() +
  theme(legend.position = "top")