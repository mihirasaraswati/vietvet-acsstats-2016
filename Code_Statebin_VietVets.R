library(statebins)
library(ggplot2)
library(survey)

viet16_design <- readRDS("Data_per16_viet_design.Rds")

mystates <- state.abb
mystates <- c(mystates[1:7], "DC", mystates[8:50], "PR")

st <- svytable(~factor(ST), viet16_design)
st <- cut(st, breaks = 5, labels = c("< 100K", "200K", "300K", "400K", "500K <"))
viet.vet.st <- data.frame(ST = mystates, Tot = as.numeric(st[1:52]), stringsAsFactors = FALSE )

statebins(state_data = viet.vet.st,
          state_col = "ST",
          value_col = "Tot",
          font_size = 3,
          dark_label = "gray5", 
          light_label = "white",
          name = "Vietnam Veteran\nPopulation (000s)",
          palette = "GnBu",
          direction = 1,
          labels = c("< 100", "200", "300", "400", "500+")
          ) +
  theme_statebins(legend_position = "right",
                  base_size = 10
                  ) +
  theme(legend.title = element_text(size = 8),
        legend.margin = margin(b = 35, l = 35, unit = "pt"))

ggsave("viet_vet_statebin.svg", device = "svg", width = 6, height = 4, units = "in")


