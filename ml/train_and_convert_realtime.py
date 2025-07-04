import os
import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

# ✅ Load dataset from correct relative path
csv_path = os.path.join(os.path.dirname(__file__), 'disease_detection_dataset.csv')
df = pd.read_csv(csv_path)

# ✅ Validate & preprocess dataset
if 'disease' not in df.columns:
    raise ValueError("CSV must contain a 'disease' column.")

# Drop unnecessary columns
X = df.drop(columns=["SerialNo", "Timestamp", "disease"])
y = df["disease"]

# ✅ Encode labels
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(y)

# ✅ Split the data
X_train, X_test, y_train, y_test = train_test_split(X, y_encoded, test_size=0.2, random_state=42)

# ✅ Build model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(64, activation='relu', input_shape=(X.shape[1],)),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(len(np.unique(y_encoded)), activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# ✅ Train model
model.fit(X_train, y_train, epochs=30, batch_size=8, validation_split=0.2)

# ✅ Evaluate model
loss, acc = model.evaluate(X_test, y_test)
print(f"✅ Test Accuracy: {acc:.2f}")

# ✅ Convert and save TFLite model
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

tflite_path = os.path.join(os.path.dirname(__file__), 'model.tflite')
with open(tflite_path, 'wb') as f:
    f.write(tflite_model)

# ✅ Save labels
label_path = os.path.join(os.path.dirname(__file__), 'labels.txt')
with open(label_path, 'w') as f:
    for label in label_encoder.classes_:
        f.write(f"{label}\n")

print("✅ Conversion complete. Files saved:")
print(f"• model.tflite at {tflite_path}")
print(f"• labels.txt at {label_path}")
