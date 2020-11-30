library(shiny)
library(markdown)

## SHINY UI
shinyUI(
  fluidPage(
    theme="bootstrap.css",
    tags$h1("WORD PREDICTION MODEL FOR AUGMENTATIVE COMMUNICATION CAPSTONE PROJECT",style="background-color: blue"),tags$br(),
    tags$hr(),
    sidebarLayout(
      sidebarPanel(
        tags$img(height = 100, width = 100, src = "bigorb.png",aling="center"),
        helpText(tags$h1("ENTER A WORD TO PREDICT THE NEXT WORD TO IT")),
        hr(),
        textInput("inputText", tags$h2("Enter your text here"),value = ""),
        hr(),
        selectInput("ngram",tags$h2("Choose number of words to show"),c("one","two","three"))  
        ),
      mainPanel(
        h2(textOutput("Headline")),
        tags$h2(verbatimTextOutput("prediction")),
        strong(tags$h2("The word that you entered is-:")),
        tags$h2(strong(em(textOutput('sentence1')))),
        plotOutput("hist")
      )
    
   )
  )
)




