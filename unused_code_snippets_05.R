``` {r Daten Struktur 3}
#@ Nina gern in 04 übernehmen... RE: Würde das in Datenbereinigung schieben
plastics %>%
  tabyl(country, year) %>%
  janitor::adorn_rounding(digits=2) %>%
  arrange(desc(`2019`))
```


``` {r Datensatz 2 audit firm, include=FALSE}


audit_firm<- plastics_prep %>%
  select(country, year, parent_company, grand_total, continent, countrycode) %>%
  # grandtotal zeilen löschen - ist schon in einer Spalte erfasst
  filter(parent_company!="Grand Total")

``` 

Welche Werte nehmen die Variablen "pvc" und "empty" an? Letzeres sind Plastikteile, die gefunden aber nicht klassifiziert wurden. Prüfe dies mit dem folgenden Code Snippet.

``` {r empty-pvc-kategorie, exercise=TRUE}

audit_plastic %>%
  tabyl(empty)

audit_plastic %>%
  tabyl(pvc)

``` 

```{r quiz_lsk, echo=FALSE}
quiz(caption = NULL,
     
     question("Welche Werte nehmen die Variablen 'pvc' nicht an?",
              answer("9"),
              answer("24"),
              answer("0", correct = TRUE),
              answer("188")
     ),
     
     question("Welche Werte nehmen die Variablen 'empty' an?",
              answer("0"),
              answer("0 oder NA", correct = TRUE),
              answer("11"),
              answer("188")
     )
)
```

```{r empty-loschen, exercise=TRUE, exercise.eval=TRUE}

audit_plastic<- audit_plastic %>%
  select(-empty)

```

```{r empty-loschen-hint}

audit_plastic<- audit_plastic %>%
  select(-empty)

```

Alle 'NA' Ausprägungen, wandeln wir in 0 um. Das ist kein allgemeingültig richtiger Umgang mit fehlenden Werten, aber für `audit_plastic` ergibt das Sinn.

```{r na-in-zero, exercise=TRUE}

audit_plastic<- audit_plastic %>%
  mutate(
    across(everything(), ~replace_na(.x, 0))
  )
```

```{r audit}
#erst zu einem langen Datensatz umwandeln
#@07 vielleicht das noch nutzen? Um auch die Arte von Plastik näher zu analysieren
#audit_plastic_long<- audit_plastic2 %>%
#   pivot_longer(cols=c(hdpe, ldpe, o, pet, pp, ps, pvc), names_to = "type", values_to = "amount")

```