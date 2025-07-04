# Keep TensorFlow Lite GPU delegate
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Required to keep GpuDelegateFactory and its inner class Options
-keep class org.tensorflow.lite.gpu.GpuDelegateFactory$Options { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegate { *; }
