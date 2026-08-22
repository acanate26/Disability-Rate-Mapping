setwd("c:/Users/acana/OneDrive/Documents/Disability through the U.S")

require(data.table)
require(tidycensus)
require(purrr)
require(ggplot2)
require(tigris)
require(sf)
require(dplyr)
require(stringr)
require(viridis)
options(tigris_use_cache = TRUE) 

disabled_csv <- fread("census_disability_by_county_2022.csv",
                      stringsAsFactors = FALSE, 
                      data.table = FALSE)

names(disabled_csv)
head(disabled_csv)
summary(disabled_csv)

####subset the disabled data file to only look at parcels in the state of NY FIPS code
ny_disabled <- disabled_csv[disabled_csv$state_fips == "36", ]
#install.packages("stringr")
disabled_csv$fips <- str_pad(as.character(disabled_csv$fips),
                             width = 5, pad = "0")

us_counties <- counties(cb = TRUE, resolution = "20m", year = 2022, class = "sf")
us_counties$GEOID <- str_pad(us_counties$GEOID,
                             width = 5, pad = "0")
us_counties_shifted <- shift_geometry(us_counties)
map_data <- us_counties_shifted %>%
  left_join(disabled_csv, by = c("GEOID" = "fips"))
sum(is.na(map_data$disability_rate))

national_map <- ggplot(map_data) +
  geom_sf(aes(fill = disability_rate), color = "white", linewidth  = 0.05) +
  scale_fill_viridis_c(
    option = "magma", 
    name = "Disability\nrate (%)",
    na.value = "grey90"
  ) +
  labs(
    title = "Disability Rate by County in the United States (2022)",
    caption = "Note: Counties with missing data are shown in grey."
  ) +
  theme_void()+
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    legend.position = "right",
  )
print(national_map)

#Optional : Zoom on your favorite state!
  
  ny_map_data <- us_counties_shifted %>%
  filter(STATEFP == "36") %>%
  left_join(disabled_csv, by = c("GEOID" = "fips"))
ny_map <- ggplot(ny_map_data) +
  geom_sf(aes(fill = disability_rate), color = "white", linewidth = 0.1) +
  scale_fill_viridis_c(option = "magma", name = "Disability\nrate (%)") +
  labs(title = "Disability Rate by County, New York (2022)") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))

print(ny_map)

#3D Version using rayshader!

unlink("C:/Users/acana/AppData/Local/R/win-library/4.4/00LOCK", recursive = TRUE)
    
install.packages("rayshader")  
require(rayshader)
library(dplyr)
require(dplyr)
require(ggplot2)

ny_map_data_clean <- ny_map_data[!is.na(ny_map_data$disability_rate), ] 

ny_map_3d_gg <- ggplot(ny_map_data_clean) +
  geom_sf(aes(fill = disability_rate), color = "white", linewidth = 0.1) +
  scale_fill_viridis_c(option = "magma", name = "Disability\nrate (%)") +
  labs(title = "Disability Rate by County, New York (2022)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 14))

"rayshader" %in% rownames(installed.packages())
library(rayshader)


## plot_gg() opens an interactive rgl window you can drag/rotate with your mouse
 

## OR take a single static snapshot instead
# render_snapshot("disability_rate_ny_3d.png")

## close the rgl window when done
# rgl::rgl.close()
                               
file.exists("disability_rate_ny_3d.gif")
getwd()  # confirms which folder R is currently pointed at
setwd("c:/Users/acana/OneDrive/Documents/Disability through the U.S")  


