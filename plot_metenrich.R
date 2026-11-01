library(tidyverse)
library(stringr)
library(ggplot2)
library(tidyr)
library(purrr)


df <- read_tsv("metabolic_enrichment.txt") %>% filter(enrichment_score > 15)



plot_df$group
plot_df <- df %>%
  pivot_longer(
    cols = matches("^(p|N)_"),
    names_to = c(".value", "group"),
    names_pattern = "^(p|N)_(.*)$"
  ) %>%
  mutate(Count = round(p * N)) %>%
  filter(map2_lgl(group, associated_groups,
                  ~ .x %in% str_split(.y, ",")[[1]])) %>%
  arrange(adjusted_q_value) %>%
  mutate(MODULE = factor(MODULE, levels = rev(unique(MODULE)))) %>%
  mutate(group = case_when(group == "Syringodium" ~ "Sy",
                           group == "Sporobolus" ~ "Sp",
                           group == "Clam" ~"Clam"))

ggplot(plot_df, aes(x = Count, y = MODULE, fill = adjusted_q_value)) +
  geom_col(color = "white", width = 0.9) +
  facet_grid(group ~ ., scales = "free_y", space = "free_y") +
  scale_fill_gradient(name = "q.adjust", low = "#D0706B", high = "#4A7DB5") +
  labs(x = "Count (genomes with module)", y = NULL) +
  theme_bw(base_size = 14) +
  theme(
    axis.text.y = element_text(size = 17, color = "black"),
    axis.text.x = element_text(size = 12, color = "black"),
    axis.title.x = element_text(size = 13),
    strip.text = element_text(size = 13, face = "bold"),
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(5, 40, 5, 5)
  )

ggsave("module_enrichment_by_group2.png", width = 15, height = 7, dpi = 300)
