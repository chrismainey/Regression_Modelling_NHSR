### Regression Modelling in R ###

### Examining Framingham data

# The Framingham Heart disease study is a long-standing cohort study that is responsible for 
# much of what we know about heart disease and associated conditions.  For more info, see:
#https://en.wikipedia.org/wiki/Framingham_Heart_Study

# We are going to use regression to investigate some of it. So first, load it:

framingham <- read.csv("./data/framingham.csv")

# The columns we have are:
# male    0 = Female; 1 = Male
# age     Age at examination time.
# education   1 = Some High School; 2 = High School or GED; 3 = Some College or Vocational School; 4 = college
# currentSmoker   0 = nonsmoker; 1 = smoker
# cigsPerDay    number of cigarettes smoked per day (estimated average)
# BPMeds    0 = Not on Blood Pressure medications; 1 = Is on Blood Pressure medications
# prevalentStroke
# prevalentHyp
# diabetes    0 = No; 1 = Yes
# totChol   mg/dL
# sysBP   mmHg
# diaBP   mmHg
# BMI   Body Mass Index calculated as: Weight (kg) / Height(meter-squared)
# heartRate   Beats/Min (Ventricular)
# glucose   mg/dL
# TenYearCHD 0 = No CHD at 10-year follow-up; 1 = CHD at 10-year follow-up



####### Part 1: Linear regression with single predictor  ##########

# With the Framingham data, we will examine the relationship between systolic blood 
# pressure and BMI. Lets view the data to see what we are working with.

summary(framingham)

View(framingham)


# A good first step is to visualise the distribution of the outcome (sysBP), and the 
# possible relationship with predictors.






## Is blood pressure relate to BMI?
## Visualise it as a scatter plot:






## Now we can build a regression model. sysBP is our outcome, and BMI our predictor.




## Can you interpret the output?  Where are the coefficients, standard errors and p-values?



## Is BMI 'significant'?  



##  How much variation in sysBP does BMI explain?





# What happens if we mean-centre and standardised BMI in the regression (using `scale`)




#  How do we interpret this?





####### Part 2: Multiple regression  ##########

# We established BMI as predictive, but it only explained ~10% of variation.
# Lets consider some more variables: currentSmoker, age, education

# BMI + currentSmoker



# BMI + age



# BMI + age + current smoker




## How would you interpret these results?


# How would you add education into this model and why?

# BMI + age + education


## How do you interpret education's coefficients?


