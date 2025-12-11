import tensorflow as tf
from  tensorflow.keras import layers,models
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical
import matplotlib.pyplot as plt
(x_train,y_train),(x_test,y_test) = mnist.load_data()

x_train = x_train/255.0
x_test = x_test/255.0

x_train = x_train.reshape((x_train.shape[0],x_train.shape[1],x_train.shape[2]))
x_test = x_test.reshape((x_test.shape[0],x_test.shape[1],x_test.shape[2]))

y_train = to_categorical(y_train,10)
y_test = to_categorical(y_test,10)
model = models.Sequential([
    layers.LSTM(128,activation="relu",input_shape=(x_train.shape[1],x_train.shape[2])),
    layers.Dense(10,activation="softmax")
])

model.compile(loss="binary_crossentropy",optimizer="adam",metrics=["accuracy"])

history = model.fit(x_train,y_train,epochs=5,validation_data=(x_test,y_test))
test_loss,test_acc = model.evaluate(x_test,y_test)
print(f"Test Accuracy is : {test_acc*100}%")
plt.figure(figsize=(10,6))
plt.subplot(1,2,1)
plt.plot(history.history["accuracy"],label="Training Accuracy")
plt.plot(history.history["val_accuracy"],label="Validation Accuracy")
plt.xlabel("Epochs")
plt.ylabel("Accuracy")
plt.title("Training v/s Validation Accuracy")
plt.legend(loc="lower right")
plt.grid(True,alpha=0.75)


plt.subplot(1,2,2)
plt.plot(history.history["loss"],label="Training Loss")
plt.plot(history.history["val_loss"],label="Validation Loss")
plt.xlabel("Epochs")
plt.ylabel("Loss")
plt.title("Training v/s Validation Loss")
plt.legend(loc="upper right")
plt.grid(True,alpha=0.75)
