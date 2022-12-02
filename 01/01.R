#%%
library(tidyverse)

ls <- read_lines("./input/01")

df <- tibble(
  l = ls
)

#%%
df |> 
  mutate(
    n = as.numeric(l),
    g = cumsum(l == '') 
  ) |> 
  group_by(g) |> 
  drop_na() |> 
  summarise(n = sum(n)) |> 
  slice_max(order_by = n, n = 3) |> 
  summarise(sum(n))
