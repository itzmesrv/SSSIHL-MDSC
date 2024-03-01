# Creating a matrix in R
A <- matrix(data=c(-3,2,893,0.17),nrow=2,ncol=2)
A # printing the matrix (by default col wise)

# Matrix Structure
matrix(data = c(1,2,3,4,5,6),nrow=2,ncol=3,byrow=TRUE) # row wise
matrix(data = c(1,2,3,4,5,6),nrow=2,ncol=3,byrow=FALSE) # col wise

# Arranging multiple vectors in array
rbind(1:3,4:6) # 1:3 in first row and 4:6 in second row
cbind(c(1,4),c(2,5),c(3,6)) # 1,4 in col1; 2,5 in col2 and 3,6 in col3

# Dimension of a matrix
mymat <- rbind(c(1,3,4),5:3,c(100,20,90),11:13)
dim(mymat) # gives mat dimension 
nrow(mymat) # no of rows
ncol(mymat) # no of cols
dim(mymat)[2] # same as no of cols

# Extracting elements of a matrix
A <- matrix(c(0.3,4.5,55.3,91,0.1,105.5,-4.2,8.2,27.9),nrow=3,ncol=3)
A

diag(x=A) # gives diagonal elements
# other operations with rows and cols
A[3,2]
A[,2]
A[2:3,]
A[,c(3,1)]
A[c(3,1),2:3]

# Manipulating Matrix
A[,-2] # remove 2nd col
A[-1,3:2]
A[-1,-2]
A[-1,-c(2,3)]

B <- A # Storing matrix A in B
B

# Other operations

B[2,] <- 1:3
B

B[c(1,3),2] <- 900
B

B[,3] <- B[3,]
B

B[c(1,3),c(1,3)] <- c(-7,7)
B

B[c(1,3),2:1] <- c(65,-65,88,-88)
B

# Making diagonal elements as 0's
diag(x=B) <- rep(x=0,times=3)
B