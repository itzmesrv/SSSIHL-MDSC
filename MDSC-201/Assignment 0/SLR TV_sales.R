# Performing Simple Linear Regression on advertising Dataset

# Importing the Dataset
dataset = read.csv("Datasets/tv_sales.csv")

# Dropping Radio and Newspaper columns/features
dataset <- subset(dataset, select = -c(Radio, Newspaper))
# Here TV data value represents advertising budget spent on TV
# And sales data value represents the resulting sales

# Splitting the Dataset into Training and Testing set
library(caTools) # loading caTools library
set.seed(123) # setting a seed
split = sample.split(dataset$Sales, SplitRatio = 2/3)
print(split) # printing the split 

training_set = subset(dataset, split== TRUE) # creating the training set
test_set = subset(dataset, split == FALSE) # creating the test set

# Fitting the Simple Linear Regression Model using Training Set
regressor = lm(formula = Sales ~ ., data = training_set) # fitting linear regression model using the training set
print(regressor)

# Predicting the Test Set Results
y_pred = predict(regressor, newdata = test_set) # predicting sales for test set
print(y_pred)

# Visualizing the Training Set Results
library(ggplot2) # loading ggplot2
ggplot() + 
  geom_point(aes(x= training_set$TV, 
                 y = training_set$Sales),
             colour = "red") + # scatter plot of training set data
  geom_line(aes(x= training_set$TV, 
                y = predict(regressor, newdata = training_set)),
            colour = "blue") + # regression line
  ggtitle("Sales Vs TV (Training Set Results)") + # setting title
  xlab("TV") + # setting x label
  ylab("Sales") # setting y label

### Visualizing the Testing Set Results
ggplot() + 
  geom_point(aes(x= test_set$TV, 
                 y = test_set$Sales),
             colour = "red") + # scatter plot of test set data
  geom_line(aes(x= test_set$TV, 
                y = y_pred),
            colour = "blue") + # regression line
  ggtitle("Sales Vs TV (Testing Set Results)") + # setting title
  xlab("TV") + # setting x label
  ylab("Sales") # setting y label

