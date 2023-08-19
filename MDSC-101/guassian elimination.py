def guass_elim(A, b):
    n = len(A)
    
    aug_mat = []
    for i in range(n):
        aug_mat.append(A[i] + [b[i]])
    
    print("\nMatrix:")
    for row in aug_mat:
        print(row)
    
    # forward
    for i in range(n):
        pivot_row = aug_mat[i]
        pivot_elem = pivot_row[i]
        
        if pivot_elem == 0:
            return "No solution"
        
        for j in range(i+1, n):
            factor = aug_mat[j][i] / pivot_elem
            for k in range(i, n+1):
                aug_mat[j][k] -= factor * pivot_row[k]
        
        print("\nNew Matrix:")
        for row in aug_mat:
            print(row)

    # inconsistent
    for i in range(n):
        if all(val == 0 for val in aug_mat[i][:-1]) and aug_mat[i][-1] != 0:
            return "No solution"
    
    # backward
    x = [0] * n
    for i in range(n-1, -1, -1):
        val = 0
        for j in range(i+1, n):
            val += aug_mat[i][j] * x[j]
        x[i] = (aug_mat[i][-1] - val) / aug_mat[i][i]

    return aug_mat, x

n = int(input("\nNumber of equations: "))
A = []
b = []
print("\nGive the coefficients:")
for i in range(n):
    eq_coeff = []
    print(f"\nEquation {i + 1}:")
    for j in range(n):
        coeff = float(input(f"Coefficient {j + 1}: "))
        eq_coeff.append(coeff)
    A.append(eq_coeff)
    b.append(float(input("Give the constant term: ")))

result = guass_elim(A, b)

if isinstance(result, str):
    print("\nSolution:", result)
else:
    row_echelon_form, solution = result
    print("\nFinal Row Echelon Form:")
    for row in row_echelon_form:
        print(row)
    print("\nSolution:", solution)