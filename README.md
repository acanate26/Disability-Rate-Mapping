# Disability-Rate-Mapping (2022)

Choropleth mapping of disability prevalence across U.S. counties using 2022 Census data, built in R with ggplot2, sf, and tigris, plus a 3D rendered/animated view of New York State using rayshader.

Overview

This project visualizes county-level disability rates (percentage of the population reporting a disability) across the United States for 2022. It includes:

A national choropleth map of all U.S. counties (Alaska and Hawaii repositioned via tigris::shift_geometry() for a clean layout).
A state-level zoom map focused on New York.
A 3D relief map and rotating GIF of New York's disability rates, rendered with rayshader, where taller/brighter counties indicate higher disability rates.


📁FILES⬇️

File	Description
disability_script.r	Full R script: data loading, cleaning, national map, NY map, and 3D rayshader visualization
census_disability_by_county_2022.csv	County-level Census data (FIPS codes, population, disability counts and rates, and breakdowns by disability type)
Rplot.pdf	Output — national U.S. county-level disability rate map
Rplot01.pdf	Output — New York State county-level disability rate map
disability_rate_ny_3d.gif	Output — rotating 3D rayshader animation of NY disability rates
Data Source

County-level disability statistics for 2022, keyed by 5-digit FIPS code, including:

Total population and total disability count
Overall disability rate (%)
Breakdown by number of disabilities (none / one / two or more)
Breakdown by disability type (hearing, vision, cognitive, ambulatory, self-care, independent living)

County boundary geometries are pulled live via tigris::counties() (Census cartographic boundary files, 2022, 20m resolution).

Requirements
r
install.packages(c(
  "data.table", "tidycensus", "purrr", "ggplot2",
  "tigris", "sf", "dplyr", "stringr", "viridis",
  "rayshader", "gifski"
))
📁 HOW IT WORKS:

Load & clean data — Read the CSV with data.table::fread(), pad FIPS codes to 5 digits with stringr::str_pad() so they match Census GEOIDs.
Fetch geometries — Pull county boundaries with tigris::counties() and shift Alaska/Hawaii into a standard inset layout with shift_geometry().
Join — Merge the disability data onto the spatial data by FIPS/GEOID.
Map (national) — Plot with geom_sf(), colored by disability_rate using the magma viridis palette; missing counties shown in grey.
Map (New York) — Filter to STATEFP == "36" and re-plot at state scale.
3D render — Convert the NY ggplot map into a 3D relief plot with rayshader::plot_gg(), then export a 90-frame orbiting GIF with render_movie().
Usage

Update the setwd() path at the top of disability_script.r to your local project folder, then run the script top to bottom. The interactive 3D view opens in an rgl window that you can rotate manually before rendering the GIF.

Notes
Color scale: dark purple/black = lower disability rate, orange/yellow = higher disability rate (viridis "magma" palette).
Counties with missing data are rendered in grey (national map) or excluded (3D NY map, which requires complete data for elevation).
The 3D scale factor (scale = 150) exaggerates differences in disability rate for visual clarity — it does not represent a literal physical unit.


<img width="900" height="900" alt="disability_rate_ny_3d" src="https://github.com/user-attachments/assets/2b93f72d-7831-487b-929e-d1538de911c5" />












