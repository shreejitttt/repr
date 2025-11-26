import numpy as np
import tensorflow as tf
from tensorflow.keras import models,layers,optimizers
import matplotlib.pyplot as plt
def create_data():
    x = np.random.randn(1000,10)
    y = np.random.randn(1000,1)
    return x,y
def create_model():
    model = models.Sequential([
        layers.Dense(50,activation="relu",input_shape=(10,)),
        layers.Dense(10,activation="relu"),
        layers.Dense(1)
    ])
    return model
def model_training(model,optimizer,epochs,batch_size,x,y,optimizer_name):
    model.compile(optimizer=optimizer,loss="mean_squared_error",metrics=["accuracy"])
    history = []
    for epoch in range(epochs):
        hist = model.fit(x,y,epochs=1,batch_size=batch_size)
        loss = hist.history["loss"][0]
        history.append(loss)
        print(f"For {epoch+1}/{epochs} for {optimizer_name} loss is : {loss*100}%")
    return history
x,y = create_data()
sgd_optimizer = optimizers.SGD(learning_rate=0.01)
adam_optimizer = optimizers.Adam(learning_rate=0.01)
sgd_model = create_model()
adam_model = create_model()
epochs = 50
batch_size = 32
sgd_loss = model_training(sgd_model,sgd_optimizer,epochs,batch_size,x,y,"SGD")
adam_loss = model_training(adam_model,adam_optimizer,epochs,batch_size,x,y,"Adam")

plt.plot(range(1,epochs+1),sgd_loss,label="SGD")
plt.plot(range(1,epochs+1),adam_loss,label="Adam")
plt.xlabel("Epochs")
plt.ylabel("Loss")
plt.title("SGD v/s Adam Loss")
plt.legend(loc="upper right")
plt.grid(True,alpha=0.75)
plt.show()
