import numpy as np
import tensorflow as tf
from tensorflow.keras import layers,models,optimizers
x = np.array([[0,0],[0,1],[1,0],[1,1]])
y = np.array([[0],[1],[1],[0]])

model = models.Sequential([
    layers.Dense(8,activation="relu",input_dim=2),
    layers.Dense(1,activation="sigmoid")
])
model.compile(loss="binary_crossentropy",optimizer=optimizers.SGD(learning_rate=0.1),metrics=["accuracy"])
history = model.fit(x,y,epochs=1000,verbose=0)
test_loss,test_acc = model.evaluate(x,y)
print(f"Test Accuracy : {test_acc*100}%")
pred = model.predict(x)
print("Predictions : ")
print(np.round(pred))
