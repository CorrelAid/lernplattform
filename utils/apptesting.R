library(httr)
app_state <- GET("https://correlaid.shinyapps.io/lernplattform")$status
if (app_state != 200){
  quit(status=1)
} else {
  # do nothing
}




### legacy code
# library(shinytest)

# Verbindung herstellen
#app <- shinytest::ShinyDriver$new("https://correlaid.shinyapps.io/lernplattform/")
#app_state <- app$.__enclos_env__$private$state
#if (app_state == "running"){
  #quit(status=1)
#} else {
  #quit(status=1)
#}

# Textbox finden
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[2]/div/div[2]/div')$click()

# Code ausführen klicken
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[1]/div[1]/div[2]/a/span')$click()

#Sys.sleep(10)

# Response finden
#app$findElement(xpath = '/html/body/div[2]/div/div[1]/div/div[1]/div[1]/div[2]/div/pre/code')