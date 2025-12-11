import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras import layers,models
from tensorflow.keras.datasets import mnist
(x_train,y_train),(x_test,y_test) = mnist.load_data()
print(f"Shape of training data : {x_train.shape}")
print(f"Shape of testing data : {x_test.shape}")

plt.subplot(221)
plt.imshow(x_train[0],cmap=plt.get_cmap("gray"))
plt.subplot(222)
plt.imshow(x_train[1],cmap=plt.get_cmap("gray"))
plt.subplot(223)
plt.imshow(x_train[2],cmap=plt.get_cmap("gray"))
plt.subplot(224)
plt.imshow(x_train[3],cmap=plt.get_cmap("gray"))
plt.show()
num_pixels = x_train.shape[1]*x_train.shape[2]
x_train = x_train.reshape(x_train.shape[0],num_pixels).astype('float32')
x_test = x_test.reshape(x_test.shape[0],num_pixels).astype('float32')

x_train = x_train/255.0
x_test = x_test/255.0
print(f"Reshaped training data : {x_train.shape}")
noise_factor = 0.2
x_train_noisy = x_train + noise_factor*np.random.normal(loc=0.0,scale=1.0,size=x_train.shape)
x_test_noisy = x_test + noise_factor*np.random.normal(loc=0.0,scale=1.0,size=x_test.shape)
x_train_noisy = np.clip(x_train_noisy,0.,1.)
x_test_noisy = np.clip(x_test_noisy,0.,1.)
print(f"Shape of noisy training data : {x_train_noisy.shape}")
model = models.Sequential([
    layers.Dense(500,input_dim=num_pixels,activation="relu"),
    layers.Dense(300,activation="relu"),
    layers.Dense(100,activation="relu"),
    layers.Dense(300,activation="relu"),
    layers.Dense(500,activation="relu"),
    layers.Dense(784,activation="sigmoid")
])
model.compile(loss="mean_squared_error",optimizer="adam",metrics=["accuracy"])
history = model.fit(x_train_noisy,x_train,epochs=2,validation_data=(x_test_noisy,x_test),batch_size=200)
pred = model.predict(x_test_noisy)
print(f"Shape of prediction : {pred.shape}")
x_test = np.reshape(x_test,(10000,28,28))*255
pred = np.reshape(pred,(10000,28,28))*255
x_test_noisy = np.reshape(x_test_noisy,(-1,28,28))*255

plt.figure(figsize=(20,4))
print("Test Images : ")
for i in range(10,20,1):
    plt.subplot(2,10,i+1)
    plt.imshow(x_test[i,:,:],cmap="gray")
    curr_label = y_test[i]
    plt.title(f"Label : {curr_label}")
plt.show()

plt.figure(figsize=(20,4))
print("Test Images with Noise : ")
for i in range(10,20,1):
    plt.subplot(2,10,i+1)
    plt.imshow(x_test_noisy[i,:,:],cmap="gray")
plt.show()

plt.figure(figsize=(20,4))
print("Predictions : ")
for i in range(10,20,1):
    plt.subplot(2,10,i+1)
    plt.imshow(pred[i,:,:],cmap="gray")
plt.show()
