import math
import random

def sigmoid(x):
    return 1 / (1 + math.exp(-x))

def dsigmoid(y):
    return y * (1 - y)

X = [[0,0], [0,1], [1,0], [1,1]]
Y = [0, 1, 1, 0]

w_hidden = [
    [random.random(), random.random()],
    [random.random(), random.random()]
]

w_output = [random.random(), random.random()]
lr = 0.5

for epoch in range(5000):
    for i in range(4):
        h1 = sigmoid(X[i][0]*w_hidden[0][0] + X[i][1]*w_hidden[0][1])
        h2 = sigmoid(X[i][0]*w_hidden[1][0] + X[i][1]*w_hidden[1][1])
        output = sigmoid(h1*w_output[0] + h2*w_output[1])

        error = Y[i] - output
        d_out = error * dsigmoid(output)

        w_output[0] += lr * d_out * h1
        w_output[1] += lr * d_out * h2

        d_h1 = dsigmoid(h1) * d_out * w_output[0]
        d_h2 = dsigmoid(h2) * d_out * w_output[1]

        w_hidden[0][0] += lr * d_h1 * X[i][0]
        w_hidden[0][1] += lr * d_h1 * X[i][1]
        w_hidden[1][0] += lr * d_h2 * X[i][0]
        w_hidden[1][1] += lr * d_h2 * X[i][1]

pred = []

for i in range(4):
    h1 = sigmoid(X[i][0]*w_hidden[0][0] + X[i][1]*w_hidden[0][1])
    h2 = sigmoid(X[i][0]*w_hidden[1][0] + X[i][1]*w_hidden[1][1])
    output = sigmoid(h1*w_output[0] + h2*w_output[1])
    pred.append([round(output)])

print("Predictions :")
print(pred)
