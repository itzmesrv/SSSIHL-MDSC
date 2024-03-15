# For a given Positive Definite Square Matrix, we beed to find its squareroot matrix

n = 3 # dimensions of matrix

# Matrix elements
mat_elements = c(2, 0, 0, 0, 2, 0, 0, 0, 3)

# Creating the matrix
M = matrix(mat_elements, nrow=n, ncol=n)

eigen_data = eigen(M) # Storing eigen values and eigen vectors in eigen_data

sqrt_eigvals = sqrt(eigen_data$values) # Square root of eigen values

lambda = diag(sqrt_eigvals) # Daigonal Matrix Lambda

# Calculating Square Root Matrix
sqrt_mat = eigen_data$vectors %*% lambda %*% solve(eigen_data$vectors)

print("Square root Matrix:")
print(sqrt_mat)