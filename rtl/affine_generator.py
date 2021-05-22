a11 = 0.75
a12 = 0.5
a21 = -0.5 
a22 = 0.75

b1 = 5
b2 = 12

x1s = [25, -32, 45]
y1s = [78, 6, -65]

for x1, y1 in zip(x1s, y1s):
    x2 = b1 + int(a11*x1) + int(a12*y1)
    y2 = b2 + int(a21*x1) + int(a22*y1)

    print("x1: {} y1: {}     \tx2: {} y2: {}".format(x1, y1, int(x2), int(y2)))
    # # print("x2 = {} + {} + {}".format(b1, int(a11*x1), int(a12*y1) ))
    # # print("y2 = {} + {} + {}".format(b2, int(a21*x1), int(a22*y1)))
    # print("\n")