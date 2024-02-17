# Performing Simple Linear Regression on the Rocket Propellant Dataset

# Importing the Dataset
dataset = read.csv("E:/Siva/SSSIHL/MSc Data Science/2nd Sem/201/Datasets/The Rocket propellant Data.csv")

# Splitting the Dataset into Training and Testing set
library(caTools) # loading caTools library
library(ggplot2) # loading ggplot2
set.seed(123) # setting a seed
split = sample.split(dataset$Shear.strength, SplitRatio = 0.8)
print(split) # printing the split 

training_set = subset(dataset, split== TRUE) # creating the training set
test_set = subset(dataset, split == FALSE) # creating the test set

# Fitting the Simple Linear Regression Model using Training Set
regressor = lm(formula = Shear.strength ~ Age.of.propellant, data = training_set) # fitting linear regression model using the training set
print(regressor)

# Predicting the Training Set Results
y_train_pred = predict(regressor, training_set)
print(y_train_pred)

# Visualizing the Training Set Results
ggplot() +
  geom_point(aes(x = training_set$Age.of.propellant,
                 y = training_set$Shear.strength),
             colour = "red") +
  geom_line(aes(x = training_set$Age.of.propellant,
                y = y_train_pred),
            colour = "blue") +
  ggtitle("Regression Line Plot Training Set")+
  xlab("Age of Propellant") + 
  ylab("Shear Strength")

# Predicting the Test Set Results
y_test_pred = predict(regressor, test_set)
print(y_test_pred)

# Visualizing the Testing Set Results
ggplot() +
  geom_point(aes(x = test_set$Age.of.propellant,
                 y = test_set$Shear.strength),
             colour = "red") +
  geom_line(aes(x = test_set$Age.of.propellant,
                y = y_test_pred),
            colour = "blue") +
  ggtitle("Regression Line Plot Testing Set")+
  xlab("Age of Propellant") + 
  ylab("Shear Strength")

# Residual Plot
train_residual = y_train_pred - training_set$Shear.strength
test_residual = y_test_pred - test_set$Shear.strength

print(ggplot() +
  geom_point(aes(x = 1:16,
                 y = train_residual),
             colour = "black") + 
  geom_hline(yintercept = 0,
             linetype = "solid",
             color = "red")) +
  ggtitle("Residual Plot Training Set")+
  xlab("Age of Propellant") + 
  ylab("Shear Strength")

ggplot() +
  geom_point(aes(x = 1:4,
                 y = test_residual),
             colour = "black") + 
  geom_hline(yintercept = 0,
             linetype = "solid",
             color = "red") +
  ggtitle("Residual Plot Testing Set")+
  xlab("Age of Propellant") + 
  ylab("Shear Strength")