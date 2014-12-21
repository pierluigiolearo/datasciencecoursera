library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Developing Data Products - Course Project'),
  sidebarPanel(
    h4('Instructions'),
    p('Enter the gross horsepower, number of cylinders, and weight of your 
      car below.  The predicted MPG will be shown to the right.'),
    h5('Please enter predictors of MPG below.'),
    numericInput('hp', 'Gross horsepower (HP):', 180, min = 80, max = 350, step = 
                   10), # example of numeric input
    radioButtons('cyl', 'Number of cylinders:', c('4' = 4, '6' = 6, '8' = 8), 
                 selected = '4'), # example of radio button input
    sliderInput("wt", 'Weight (lbs):',
                min = 1500, max = 5500, value = 3200)),
  mainPanel(
    h4('Predicted MPG'),
    h5('You entered:'),
    verbatimTextOutput("inputValues"),
    h5('Which resulted in a prediction of:'),
    verbatimTextOutput("prediction"),
    h5('MPG relative to cars in mtcars data set'),
    plotOutput('plots'),
    h4('Method'),
    p('We have fit a linear model to the mtcars dataset, modeling the effect of 
          horsepower, number of cylinders, and weight on the mpg.  Since the 
          only valid possibilities for number of cylinders in the dataset were 
          4, 6, and 8, we have limited the choice using radio buttons.  For the weight,
          reactive() is used to convert the user input weight into the units 
          used by the model, lb/1000.  Finally, a pre-set function using the 
          linear model is used to predict the mpg based on the three variables 
          input by the user.')
  )
))