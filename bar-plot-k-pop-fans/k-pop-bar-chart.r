library(ggplot2)

kpop_music_group_heights <- read.table("bar-plot-k-pop-fans/resources/kpop_heights.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, fill = TRUE)
colnames(kpop_music_group_heights) <- c("Group", "Height")

# Trying to reorder the bars like in the original plot
kpop_music_group_heights$Group <- reorder(kpop_music_group_heights$Group, -kpop_music_group_heights$Height)

plot <- ggplot(kpop_music_group_heights, aes(x = Group, y = Height, fill = Group)) +
    geom_bar(stat = "identity", color = "orange") +
    geom_text(aes(y = Height + 0.5, label = paste(round(Height, 1), "cm")), color = "black", fontface = "bold") +
    scale_fill_manual(values = rep("orange", length(kpop_music_group_heights$Group))) +
    coord_cartesian(ylim = c(150, max(kpop_music_group_heights$Height) + 2)) +
    theme_minimal(base_size = 15) +
    theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(color = "black", face = "bold"),
        axis.ticks.x = element_blank(),
        legend.position = "none",
        panel.grid = element_blank(),
        plot.background = element_rect(fill = "white"),
        axis.line.x = element_line(color = "orange"),
        axis.line.y = element_blank(),
        panel.border = element_blank()
    ) +
    labs(x = NULL, y = NULL)

ggsave("kpop_heights_plot.png", plot = plot, width = 8, height = 6, dpi = 300)