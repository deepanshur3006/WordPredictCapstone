library(stringr)
library(tidytext)
library(dplyr)
library(tidyr)
library(caret)
library(tm)
library(stylo)
library(reshape)
library(shiny)


##traininngramTwo<-read.table('twogram.txt')
##traininngramThree<-read.table('threegram.txt')
##traininngramFour<-read.table('fourgram.txt')

shinyUI(fluidPage(
    
    titlePanel("Welcome To The Word Prediction App"),
    sidebarLayout(
        sidebarPanel(
            h3('Please enter some text below and we will recommend the next word for you'),
            br(),
            textInput("inputtext", "Enter Your Text"),
            em('Tip: Avoid incomplete or misspelled words')
                         
                    ),
        mainPanel(
            tabsetPanel(
                
                type='tabs',
                tabPanel('Prediction App',h3('Here are the predictions for the next word'),
                         br(),
                         strong(textOutput("predictedwords")),
                         br(),
                         strong(textOutput("predictedwords2")),
                         br(),
                         strong(textOutput("predictedwords3")),
                         br(),br(),
                         em('Please give about 15 seconds for the first prediction to appear.'),
                         br(),em('Thanks for your patience. Use the time to go through our info.'),
                         h3('We bet one of these words was on your mind')),
                tabPanel('Info',h3('How To Use?'),br(),
                         em('1. Enter text in the text box on the left side of App'),br(),
                         em('2. The App takes about 15 seconds for the first prediction'),br(),
                         em('3. Once the first prediction appears, it will run smoothly'),br(),
                         em('4. NA just indicates that we already gave the best prediction above'),
                         br(),br(),
                         h3('Important Links'),br(),
                         em('1. Link to the Pitch Presentation:'),br(),
                         em('2. Link to Github repo for source codes:')
            )
           
            
        )
    )
)))
