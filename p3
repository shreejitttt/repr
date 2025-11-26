import tensorflow as tf
from tensorflow.keras import models,layers
from tensorflow.keras.datasets import mnist
import matplotlib.pyplot as plt
(train_images,train_labels),(test_images,test_labels) = mnist.load_data()

train_images = train_images.reshape((-1,28,28,1))
test_images = test_images.reshape((-1,28,28,1))

train_images = train_images/255.0
test_images = test_images/255.0
model = models.Sequential([
    layers.Conv2D(32,(3,3),activation="relu",input_shape=(28,28,1)),
    layers.MaxPooling2D((2,2)),
    layers.Conv2D(64,(3,3),activation="relu"),
    layers.Flatten(),
    layers.Dense(64,activation="relu"),
    layers.Dense(10,activation="softmax")
])
model.compile(loss="sparse_categorical_crossentropy",optimizer="adam",metrics=["accuracy"])
history = model.fit(train_images,train_labels,epochs=5,validation_data=(test_images,test_labels))
test_loss,test_acc = model.evaluate(test_images,test_labels)
print(f"Test Accuracy : {test_acc*100}%")
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
