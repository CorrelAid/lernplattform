library(tidyverse)
library(janitor)
library(countrycode)
library(learnr)
library(here)


plastics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')


# Daten für 05 bereinigen
# Country name cleaning: 
#United Kingdom of Great Britain & Northern Ireland ssowie für die USA
plastics_prep <- plastics %>%
  # nur 2019 weil 2020 wegen der Pandemie ein nicht repräsentatives Jahr ist
  filter(year==2019) %>%
  mutate(country = str_replace(country, "United Kingdom of Great Britain & Northern Ireland", "United Kingdom"),
         country = str_replace(country, "United States of America", "United States"),
         country = str_to_title(country) ) %>% #um z.B.: ECUADOR etc case ändern
  #Continent und country code anspielen
  mutate(continent = countrycode::countrycode(country, origin = "country.name", destination = "continent"),
         countrycode = countrycode::countrycode(country, origin = "country.name", destination = "iso3c")) %>%
  mutate(continent=replace_na(continent, "Unknown"),
         countrycode=replace_na(countrycode, "Unknown"))

# Community Datensatz für 05
community<- plastics_prep %>%
  select(country, year, num_events, volunteers, grand_total, continent, countrycode) %>%
  group_by(country, year) %>%
  filter(row_number()==1)

# Audit plastik Datensatz für 05

audit_plastic<- plastics_prep %>%
  # nur grandtotal zeile behalten
  filter(parent_company=="Grand Total") %>%
  select(-c(parent_company, num_events, volunteers, empty)) %>%
  #NA zu 0
  mutate(
    across(everything(), ~replace_na(.x, 0))
  )

# EU-Asien Audit plastik Datensatz für 05
audit_plastic_eu_asia<- audit_plastic %>%
  filter(continent == "Europe" | continent == "Asia") %>%
  group_by(country) %>%
  mutate(n_types=sum(c(hdpe, ldpe, o, pet, pp, ps, pvc)!=0))

#r mogl_lsg_viz

audit_plastic %>%
  filter(grand_total>15000)


audit_plastic %>%
  filter(continent!="Unknown") %>%
  ggplot(aes(continent, grand_total)) +
  geom_point(position = position_jitter(width=0.3), size=3, alpha = 0.6) + 
  coord_cartesian(ylim=c(0,15000)) +
  labs(title = "Beteiligung an 'Break free from Plastic' ..." ,
       subtitle= "... unterscheidet sich nach Kontinent.",
       y = "Anzahl gefundener Plastikstücke",
       x = "Kontinent",
       caption = "In Nigeria, Philippinen und Taiwan wurden 19841, 28055 und \n120646 Plastikstücke gesammelt. Diese Beoachtungen \nwurden zur Lesbarkeit ausgeklammert.") +
  theme_minimal()


#r mogl_lsg_kennzahl

community %>%
  group_by(continent) %>%
  summarize(Länderanzahl=n(),
            Teilnehmner=sum(volunteers))

