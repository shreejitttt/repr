import tensorflow as tf
from tensorflow.keras import layers,models
from tensorflow.keras.datasets import imdb
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.layers import Embedding,Bidirectional,LSTM,Dense,Dropout
from sklearn.model_selection import train_test_split
num_words = 1000
maxlen = 200
(x_train,y_train),(x_test,y_test) = imdb.load_data(num_words=num_words)
x_train = pad_sequences(x_train,maxlen=maxlen)
x_test = pad_sequences(x_test,maxlen=maxlen)

x_train,x_val,y_train,y_val = train_test_split(x_train,y_train,test_size=0.2,random_state=42)

model = models.Sequential([
    layers.Embedding(input_dim = num_words,output_dim = 128,input_length = maxlen),
    layers.Bidirectional(LSTM(64,return_sequences=False)),
    layers.Dropout(0.5),
    layers.Dense(1,activation="sigmoid")
])
model.compile(optimizer="adam",loss="binary_crossentropy",metrics=["accuracy"])
history = model.fit(x_train,y_train,epochs=5,batch_size=200,validation_data=(x_val,y_val))
test_loss,test_acc = model.evaluate(x_val,y_val)
print(f"Validation Accuracy : {test_acc*100}%")
def decode_review(encoded_review):
    word_index = imdb.get_word_index()
    reverse_word_index = {value:key for key,value in word_index.items()}
    decoded_review = " ".join([reverse_word_index.get(i-3,"?") for i in encoded_review if i>2])
    return decoded_review

def predict_sentiment(review):
    word_index = imdb.get_word_index()
    encoded_review = [word_index.get(word,0)+3 for word in review.split()]
    padded_review = pad_sequences([encoded_review],maxlen=maxlen)
    pred = model.predict(padded_review,verbose=0)
    sentiment = "Positive" if pred[0][0]>=0.5 else "Negative"
    return sentiment
print("\nSentiment Analysis of IMDB Dataset : \n")
for i in range(5):
    review = decode_review(x_test[i])
    sentiment = predict_sentiment(review)
    print("="*50)
    print("Review : \n",review)
    print("Sentiment : \n",sentiment)
    print("="*50)
