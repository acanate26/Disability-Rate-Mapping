# Disability-Rate-Mapping (2022)
Visualizes county-level disability rates across the United States using 2022 Census data, with both a static national choropleth map and an interactive 3D extrusion of New York State.

What this does
Loads county-level disability data from census_disability_by_county_2022.csv
Joins it to U.S. Census county boundary shapefiles (via tigris)
Renders a national choropleth map (PNG)
Renders a zoomed-in New York State choropleth map (PNG)
Extrudes the New York map into an interactive 3D scene (via rayshader) and exports it as a rotating orbit GIF
Requirements
R (4.4+ recommended)
RStudio or R console

install.packages(c(
  "data.table",
  
  "tidycensus",
  
  "purrr",
  
  "ggplot2",
  
  "tigris",
  
  "sf",
  
  "dplyr",
  
  "stringr",
  
  "viridis",
  
  "rayshader",
  
  "gifski"
))

    <img width="900" height="900" alt="disability_rate_ny_3d" src="https://github.com/user-attachments/assets/2b93f72d-7831-487b-929e-d1538de911c5" />












