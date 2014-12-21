---
title: "Analysis of the mtcars dataset"
author: "Pier Luigi (A Data Science Student)"
highlighter: highlight.js
output:
  html_document:
    number_sections: yes
    toc: yes
job: Reproducible Pitch Presentation
knit: slidify::knit2slides
mode: selfcontained
hitheme: tomorrow
subtitle: Variables and MPG (miles per gallon)
framework: io2012
widgets: bootstrap
---

## Coursera Reproducible Pitch

### See the Regression Models Course Project  

- URL: *https://github.com/pierluigiolearo/datasciencecoursera*  
- Find here all the data that have been use for this presentation and also for the first part of the data Science Project: "First, you will create a Shiny application and deploy it on Rstudio's servers.Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application."  
- "Since the beginning of the Data Science Specialization, we've noticed the unbelievable passion students have about our courses and the generosity they show toward each other on the course forums. A couple students have created quality content around the subjects we discuss, and many of these materials are so good we feel that they should be shared with all of our students."

### Find all details here
- URL: *https://class.coursera.org/devdataprod-007*  



---

## mtcars dataset

### Motor Trend Car Road Tests

> The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

### Source
> Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.


```r
library(datasets)
head(mtcars, 4)
```

```
##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710     22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
```

---

## mtcars dataset - Format

**A data frame with 32 observations on 11 variables.**

| Index | Field |        Detail         |
------- | ----- | --------------------- |
| [, 1] | mpg   | Miles/(US) gallon     |
| [, 2] | cyl   | Number of cylinders   |
| [, 3]	| disp  | Displacement (cu.in.) |
| [, 4]	| hp    | Gross horsepower      |
| [, 5]	| drat  | Rear axle ratio       |
| [, 6]	| wt    | Weight (lb/1000)                         |
| [, 7]	| qsec  | 1/4 mile time                            |
| [, 8]	| vs    | V/S                                      |
| [, 9]	| am    | Transmission (0 = automatic, 1 = manual) |
| [,10]	| gear  | Number of forward gears                  |
| [,11]	| carb  | Number of carburetors                    |

---

## Analysis - main code

```r
  formulaTextPoint <- reactive({
    paste("mpg ~", "as.integer(", input$variable, ")")  })
  
  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data=mpgData)  })
  ...
  output$fit <- renderPrint({
    summary(fit()) })
  
  output$mpgPlot <- renderPlot({
    with(mpgData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })  })

```


