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
# education   1 = Some High School; 2 = High School or GED;
#             3 = Some College or Vocational School; 4 = college
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
# possible relationship with predictor, BMI.

# Firstly, draw a histogram, box-plot or you choice to view the distribution of sysBP.



## Is blood pressure relate to BMI?
## Next, visualise this by building a scatter plot of sysBP and BMI:






## Now let's build a linear regression model. sysBP is our outcome, and BMI our predictor.
## create an object with a name, using the `lm` function.




## Use the summary function to view the model
## Can you interpret the output?  Where are the coefficients, standard errors and p-values?



## Is BMI 'significant'?  



##  How much variation in sysBP does BMI explain?





# What happens if we mean-centre and standardised BMI in the regression (using `scale`)




#  How do we interpret this?





####### Part 2: Multiple regression  ##########

# We established BMI as predictive, but it only explained ~10% of variation.
# Lets consider adding some more variables: currentSmoker, age, education
# Build models for each of the following, and look at the output

# BMI + currentSmoker



# BMI + age



# BMI + age + current smoker




## How would you interpret these results?


# How would you add the 'education' variable into this model and why?
# Build a model with BMI + age + education as predictors and view the output


## How do you interpret education's coefficients?


