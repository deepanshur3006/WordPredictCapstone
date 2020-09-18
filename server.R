library(stringr)
library(tidytext)
library(dplyr)
library(tidyr)
library(caret)
library(tm)
library(stylo)
library(reshape)
library(shiny)

trainngramTwo<-read.table('twogram.txt',encoding = 'UTF-8',stringsAsFactors = FALSE)
trainngramThree<-read.table('threegram.txt',encoding = 'UTF-8',stringsAsFactors = FALSE)
trainngramFour<-read.table('fourgram.txt',encoding = 'UTF-8',stringsAsFactors = FALSE)

shinyServer(function(input, output) {
    
    
   
    
    output$predictedwords <- renderText({
        
        
            
        
            prediction<-character()
            prediction<-nextwordpredict(input$inputtext)
            
            output$predictedwords2<-renderText({
                
                return(prediction[2])
                
            })
            
            output$predictedwords3<-renderText({
                
                return(prediction[3])
                
            })
       
            return(prediction[1])
            
            
            
    
    })
    
    
    
    nextwordpredict <- function(input)
    {
        
        #Cleaning the input
        wordInput <- cleanInput(input)
        #Getting the number of words in the input
        wordCount <- length(wordInput)
        #Initializing response
        prediction <- character()
        
        #Trimming input to the last three words
        if(wordCount>3)
        {
            wordInput <- wordInput[(wordCount-2):wordCount]
            prediction <- matchinFourGram(wordInput[1],wordInput[2],wordInput[3])
        }
        
        #Four Gram Match
        if(wordCount ==3)
        {
            prediction <- matchinFourGram(wordInput[1],wordInput[2],wordInput[3])
        }
        
        #Three Gram Match
        if(wordCount ==2)
        {
            
            prediction <- matchThreeGram(wordInput[1],wordInput[2])
        }
        #Two gram match
        if(wordCount ==1)
        {
            prediction <- matchTwoGram(wordInput[1])
        }
        
        #No word entered
        if(wordCount == 0)
        {
            prediction <- "No Input Found"
        }
        
        #Unknown words
        if(length(prediction)==0)
        {
            prediction <- "Sorry! Didn't Get It"
        }
        
        #Returning response
        if(length(prediction) < 5)
        {
            prediction
        }
        else
        {
            prediction[1:5]
        }
        
        
    }
    
    
    
    #Cleaning input to extract specific words
    cleanInput <- function(text){
        textInput <- tolower(text)
        textInput <- removePunctuation(textInput)
        textInput <- removeNumbers(textInput)
        textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
        textInput <- stripWhitespace(textInput)
        textInput <- txt.to.words.ext(textInput,   preserve.case = TRUE)
        return(textInput)
    }
    
    #Match string in Four Gram and get probable word
    matchinFourGram <- function (inputWord1,inputWord2,inputWord3)
        
    {
        
        
        
        
        predictWord <- filter(trainngramFour,(word1 == inputWord1 & word2 == inputWord2 & word3 == inputWord3))$word4
        if(length(predictWord) == 0)
        {
            
            predictWord <- filter(trainngramFour,( word2 == inputWord2 & word3 == inputWord3))$word4
            if(length(predictWord) == 0)
            {
                predictWord <- filter(trainngramFour,( word1 == inputWord2 & word2 == inputWord3))$word3
                
                
                if(length(predictWord) ==0)
                {
                    predictWord <- matchThreeGram(inputWord2,inputWord3)
                }
                
            }
            
        }
        
        predictWord
        
    }
    
    
    
    #Match string in Three Gram and get probable word
    matchThreeGram <- function(inputWord1,inputWord2)
    {
        
        
        predictWord <- filter(trainngramThree,( word1 == inputWord1 & word2 == inputWord2))$word3
        if(length(predictWord)==0)
        {
            predictWord <- filter(trainngramThree,(word2 == inputWord2))$word3 
            
            if(length(predictWord)== 0)
            {
                predictWord <- filter(trainngramThree,(word1 == inputWord2))$word2 
                
                if(length(predictWord) ==0 )
                {
                    predictWord <- matchTwoGram(inputWord2)
                }
                
            }
        }
        predictWord
    }
    
    #Match string in Two Gram and get probable word
    matchTwoGram <- function(inputWord1)
    {
        
        predictWord <- filter(trainngramTwo,( word1 == inputWord1 ))$word2
        
        predictWord
        
    }
    
    
    
})
