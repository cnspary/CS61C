#include "matrix.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

// Include SSE intrinsics
#if defined(_MSC_VER)
#include <intrin.h>
#elif defined(__GNUC__) && (defined(__x86_64__) || defined(__i386__))
#include <immintrin.h>
#include <x86intrin.h>
#endif

/* Below are some intel intrinsics that might be useful
 * void _mm256_storeu_pd (double * mem_addr, __m256d a)
 * __m256d _mm256_set1_pd (double a)
 * __m256d _mm256_set_pd (double e3, double e2, double e1, double e0)
 * __m256d _mm256_loadu_pd (double const * mem_addr)
 * __m256d _mm256_add_pd (__m256d a, __m256d b)
 * __m256d _mm256_sub_pd (__m256d a, __m256d b)
 * __m256d _mm256_fmadd_pd (__m256d a, __m256d b, __m256d c)
 * __m256d _mm256_mul_pd (__m256d a, __m256d b)
 * __m256d _mm256_cmp_pd (__m256d a, __m256d b, const int imm8)
 * __m256d _mm256_and_pd (__m256d a, __m256d b)
 * __m256d _mm256_max_pd (__m256d a, __m256d b)
*/

/* Generates a random double between low and high */
double rand_double(double low, double high) {
    double range = (high - low);
    double div = RAND_MAX / range;
    return low + (rand() / div);
}

/* Generates a random matrix */
void rand_matrix(matrix *result, unsigned int seed, double low, double high) {
    srand(seed);
    for (int i = 0; i < result->rows; i++) {
        for (int j = 0; j < result->cols; j++) {
            set(result, i, j, rand_double(low, high));
        }
    }
}

/*
 * Allocates space for a matrix struct pointed to by the double pointer mat with
 * `rows` rows and `cols` columns. You should also allocate memory for the data array
 * and initialize all entries to be zeros. `parent` should be set to NULL to indicate that
 * this matrix is not a slice. You should also set `ref_cnt` to 1.
 * You should return -1 if either `rows` or `cols` or both have invalid values, or if any
 * call to allocate memory in this function fails. Return 0 upon success.
 */
int allocate_matrix(matrix **mat, int rows, int cols) {
    /* TODO: YOUR CODE HERE */
    if (rows <= 0 || cols <= 0)
        return -1;
    
    *mat = (matrix *)malloc(sizeof(matrix));
    if (*mat == NULL)
        return -1;

    (*mat)->rows = rows;
    (*mat)->cols = cols;

    (*mat)->data = (double *)malloc(sizeof(double) * rows * cols);
    if ((*mat)->data == NULL)
        return -1;
    
    (*mat)->ref_cnt = 1;
    (*mat)->parent = NULL;

    fill_matrix(*mat, 0);

    return 0;
}

/*
 * Allocates space for a matrix struct pointed to by `mat` with `rows` rows and `cols` columns.
 * Its data should point to the `offset`th entry of `from`'s data (you do not need to allocate memory)
 * for the data field. `parent` should be set to `from` to indicate this matrix is a slice of `from`.
 * You should return -1 if either `rows` or `cols` or both are non-positive or if any
 * call to allocate memory in this function fails. Return 0 upon success.
 */
int allocate_matrix_ref(matrix **mat, matrix *from, int offset, int rows, int cols) {
    /* TODO: YOUR CODE HERE */
    if (rows <= 0 || cols <= 0)
        return -1;
    
    *mat = (matrix *)malloc(sizeof(matrix));
    if (*mat == NULL)
        return -1;

    (*mat)->rows = rows;
    (*mat)->cols = cols;

    (*mat)->data = (from->data + offset);
    from->ref_cnt += 1;
    
    (*mat)->ref_cnt = 1;
    (*mat)->parent = from;

    return 0;
}

/*
 * You need to make sure that you only free `mat->data` if `mat` is not a slice and has no existing slices,
 * or if `mat` is the last existing slice of its parent matrix and its parent matrix has no other references
 * (including itself). You cannot assume that mat is not NULL.
 */
void deallocate_matrix(matrix *mat) {
    /* TODO: YOUR CODE HERE */
    if (mat == NULL)
        return ;

    if (mat->ref_cnt == 1 && mat->parent == NULL) {
        free(mat->data);
        free(mat);
    } else if (mat->ref_cnt == 1 && mat->parent != NULL) {
        mat->parent->ref_cnt -= 1;
        if (mat->parent->ref_cnt == 1) {
            free(mat->parent->data);
            free(mat->parent);
        }
        free(mat);
    } else if(mat->ref_cnt > 1) {
        mat->ref_cnt -= 1;
    }
}

/*
 * Returns the double value of the matrix at the given row and column.
 * You may assume `row` and `col` are valid.
 */
double get(matrix *mat, int row, int col) {
    /* TODO: YOUR CODE HERE */
    return *(mat->data + row * mat->cols + col);
}

/*
 * Sets the value at the given row and column to val. You may assume `row` and
 * `col` are valid
 */
void set(matrix *mat, int row, int col, double val) {
    /* TODO: YOUR CODE HERE */
    *(mat->data + row * mat->cols + col) = val;
}

/*
 * Sets all entries in mat to val
 */
void fill_matrix(matrix *mat, double val) {
    /* TODO: YOUR CODE HERE */
    double *p = mat->data;
    for (int i = 0; i < mat->rows * mat->cols; ++i) {
        *p = val;
        p++;
    }
}


/*
 * Check matrix 
 */
int checker(matrix *res, matrix *mat1, matrix *mat2, int sameD) {
    if (res == NULL || mat1 == NULL || mat2 == NULL)
        return -1;
    
    if (res->data == NULL || mat1->data == NULL || mat2->data == NULL)
        return -1;

    if (res->rows != mat1->rows || res->cols != mat2->cols)
        return -1;

    if (sameD != 0 && (mat1->rows != mat2->rows || mat1->cols != mat2->cols))
        return -1;

    return 0;
}

/* Performs the operation OPERATION on operands and stores the resulting matrix in result. */
int mat_op_helper(matrix *result, matrix *mat1, matrix *mat2, char operation) {
    for (int i = 0; i < result->rows; ++i) {
        for (int j = 0; j < result->cols; ++j) {
            double a = *(mat1->data + i * mat1->cols + j);
            double b = *(mat2->data + i * mat1->cols + j);
            double c = 0;

            if (operation == '+') {
                c = a + b;
            } else if (operation == '-') {
                c = a - b;
            } else if (operation == 'n') {
                c = -a;
            } else if (operation == 'a') {
                c = (a >= 0) ? a : -a;
            } else if (operation == 'I') {
                c = (i == j) ? 1 : 0;
            } else if (operation == 's') {
                c = a;
            } else if (operation == 'z') {
                c = 0.0;
            }

            set(result, i, j, c);
        }
    }

    return 0;
}

/*
 * Store the result of adding mat1 and mat2 to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 */
int add_matrix(matrix *result, matrix *mat1, matrix *mat2) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat1, mat2, 1) != 0)
        return -1;

    mat_op_helper(result, mat1, mat2, '+');

    return 0;
}

/*
 * Store the result of subtracting mat2 from mat1 to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 */
int sub_matrix(matrix *result, matrix *mat1, matrix *mat2) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat1, mat2, 1) != 0)
        return -1;

    mat_op_helper(result, mat1, mat2, '-');

    return 0;
}

/*
 * Store the result of multiplying mat1 and mat2 to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 * Remember that matrix multiplication is not the same as multiplying individual elements.
 */
int mul_matrix(matrix *result, matrix *mat1, matrix *mat2) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat1, mat2, 0) != 0)
        return -1;  

    mat_op_helper(result, mat1, mat2, 'z');
    
    for(int i = 0; i < result->rows; ++i)
        for (int j = 0; j < result->cols; ++j)
            for(int k = 0; k < mat1->cols; ++k) {
                set(result, i, j, get(result, i, j) + get(mat1, i, k) * get(mat2, k, j));
            }
    
    return 0;
}

/*
 * Store the result of raising mat to the (pow)th power to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 * Remember that pow is defined with matrix multiplication, not element-wise multiplication.
 */
int pow_matrix(matrix *result, matrix *mat, int pow) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat, mat, 0) != 0)
        return -1;  

    if (mat->rows != mat->cols)
        return -1;

    matrix *tmp;

    if (pow == 0) {
        return mat_op_helper(result, mat, mat, 'I');
    } else if (pow == 1) {
        return mat_op_helper(result, mat, mat, 's');
    } else {
        mat_op_helper(result, mat, mat, 'I');

        if (allocate_matrix(&tmp, result->rows, result->cols) != 0)
            return -1;

        for (int i = 0; i < pow; ++i) {
            
            if (mul_matrix(tmp, result, mat) != 0)
                return -1;

            mat_op_helper(result, tmp, tmp, 's');
        }

        deallocate_matrix(tmp);
    }

    return 0;
}

/*
 * Store the result of element-wise negating mat's entries to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 */
int neg_matrix(matrix *result, matrix *mat) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat, mat, 0) != 0)
        return -1;

    mat_op_helper(result, mat, mat, 'n');

    return 0;
}

/*
 * Store the result of taking the absolute value element-wise to `result`.
 * Return 0 upon success and a nonzero value upon failure.
 */
int abs_matrix(matrix *result, matrix *mat) {
    /* TODO: YOUR CODE HERE */
    if (checker(result, mat, mat, 0) != 0)
        return -1;

    mat_op_helper(result, mat, mat, 'a');

    return 0; 
}

