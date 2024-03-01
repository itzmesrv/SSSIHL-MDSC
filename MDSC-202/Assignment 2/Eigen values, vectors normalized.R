# Creating Matrix A
A <- matrix(c(0.3,4.5,55.3,91,0.1,105.5,-4.2,8.2,27.9),nrow=3,ncol=3)
print('Matrix: ') 
A # printing the matrix

# Using eigen function and storing the result
eigen_res <- eigen(A)
print('Eigen Values are: ')
eigen_res$values # printing eigen values
print('Eigen Vectors are: ')
print(eigen_res$vectors) # printing eigen vectors

# calculating normalized eigen vectors
norm_vectors <- eigen_res$vectors / sqrt(colSums(eigen_res$vectors^2))
print(norm_vectors) # printing the normlaized eigen vectors