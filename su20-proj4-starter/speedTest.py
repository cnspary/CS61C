import time
import numc as nc
import numpy as np
import threading


def addTime():
    print("=" * 60)
    print("{:^54}".format("test Add speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    size = [1000, 2000, 5000, 10000]
    for s in size:
        mat1 = nc.Matrix(s, s, rand=True)
        mat2 = nc.Matrix(s, s, rand=True)

        start1 = time.time()
        res = mat1 + mat2
        end1 = time.time()

        mat1 = np.random.random((s, s))
        mat2 = np.random.random((s, s))

        start2 = time.time()
        res = mat1 + mat2
        end2 = time.time()
        print("Add two {:6d} by {:6d} matrices {:10.3f} {:10.3f}".format(
            s, s, end1 - start1, end2 - start2))


def subTime():
    print("=" * 60)
    print("{:^54}".format("test Sub speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    size = [1000, 2000, 5000, 10000]
    for s in size:
        mat1 = nc.Matrix(s, s, rand=True)
        mat2 = nc.Matrix(s, s, rand=True)

        start1 = time.time()
        res = mat1 - mat2
        end1 = time.time()

        mat1 = np.random.random((s, s))
        mat2 = np.random.random((s, s))

        start2 = time.time()
        res = mat1 - mat2
        end2 = time.time()

        print("Sub two {:6d} by {:6d} matrices {:10.3f} {:10.3f}".format(
            s, s, end1 - start1, end2 - start2))


def mulTime():
    print("=" * 60)
    print("{:^54}".format("test Mul speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    size = [100, 1000, 2000, 5000]
    for s in size:
        mat1 = nc.Matrix(s, s, rand=True)
        mat2 = nc.Matrix(s, s, rand=True)

        start1 = time.time()
        res = mat1 * mat2
        end1 = time.time()

        mat1 = np.random.random((s, s))
        mat2 = np.random.random((s, s))
        start2 = time.time()
        res = mat1 @ mat2
        end2 = time.time()

        print("Multiply two {:6d} by {:6d} matrices {:10.3f} {:10.3f}".format(
            s, s, end1 - start1, end2 - start2))


def negTime():
    print("=" * 60)
    print("{:^54}".format("test Neg speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    size = [1000, 2000, 5000, 10000]
    for s in size:
        mat1 = nc.Matrix(s, s, rand=True)

        start1 = time.time()
        res = -mat1
        end1 = time.time()

        mat1 = np.random.random((s, s))
        start2 = time.time()
        res = np.abs(mat1)
        end2 = time.time()

        print("Negate a {:6d} by {:6d} matrices {:10.3f} {:10.3f}".format(
            s, s, end1 - start1, end2 - start2))


def absTime():
    print("=" * 60)
    print("{:^54}".format("test Abs speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    size = [1000, 2000, 5000, 10000]
    for s in size:
        mat1 = nc.Matrix(s, s, rand=True)
        mat2 = nc.Matrix(s, s, rand=True)

        start1 = time.time()
        res = abs(mat1)
        end1 = time.time()

        mat1 = np.random.random((s, s))
        start2 = time.time()
        res = np.abs(mat1)
        end2 = time.time()

        print("Absolute a {:6d} by {:6d} matrices {:10.3f} {:10.3f}".format(
            s, s, end1 - start1, end2 - start2))


def powTime():
    print("=" * 60)
    print("{:^54}".format("test Pow speed"))
    print("{:>34}{:>10}{:>10}".format(" ", "numc", "NumPy"))
    print("=" * 60)
    for s in [100, 1000]:
        for p in [0, 1, 2, 5, 10, 100]:
            mat1 = nc.Matrix(s, s, rand=True)

            start1 = time.time()
            res = mat1 ** p
            end1 = time.time()

            mat1 = np.random.random((s, s))
            start2 = time.time()
            res = np.power(mat1, p)
            end2 = time.time()

            print("{:5d}th power a {:5d} by {:6d} matrices {:10.3f} {:10.3f}".format(
                p, s, s, end1 - start1, end2 - start2))


def main():
    # addTime()
    # subTime()
    # mulTime()
    negTime()
    absTime()
    # powTime()


if __name__ == "__main__":
    main()
