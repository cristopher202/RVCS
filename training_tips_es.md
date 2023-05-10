Instrucciones y consejos para el entrenamiento de RVC
======================================
Estos TIPS explican cómo se realiza el entrenamiento de datos.

# Flujo de entrenamiento
Explicaré los pasos en la pestaña de entrenamiento de la GUI.

## paso 1
Establezca el nombre del experimento aquí

También puede establecer aquí si el modelo debe tener en cuenta el tono.
Si el modelo no tiene en cuenta el tono, el modelo será más ligero, pero no apto para cantar.

Los datos de cada experimento se colocan en `/logs/your-experiment-name/`.

## paso2a
Carga y preprocesa el audio.

### cargar audio
Si especifica una carpeta con audio, los archivos de audio en esa carpeta se leerán automáticamente.
Por ejemplo, si especifica `C:Users\hoge\voices`, `C:Users\hoge\voices\voice.mp3` se cargará, pero `C:Users\hoge\voices\dir\voice.mp3` no se cargará.

Dado que ffmpeg se usa internamente para leer audio, si la extensión es compatible con ffmpeg, se leerá automáticamente.
Después de convertir a int16 con ffmpeg, convierta a float32 y normalice entre -1 y 1.

### eliminación de ruido (denoising)
El audio es suavizado por filtfilt de scipy.

### División de audio (audio split)
Primero, el audio de entrada se divide detectando partes de silencio que duran más de cierto período (max_sil_kept=5 segundos?). 
Después de dividir el audio en silencio, divide el audio cada 4 segundos con una superposición de 0,3 segundos.
Para el audio separado en 4 segundos, después de normalizar el volumen, convierte el archivo wav a `/logs/your-experiment-name/0_gt_wavs` y luego se convierte a una frecuencia de muestreo de 16k a `/logs/your-experiment-name/1_16k_wavs` como un archivo wav.

## paso2b
### Extraer tono (extract pitch)
Extrae información de tono de archivos wav. Extrae la información de tono (=f0) utilizando el método integrado en parselmouth o pyworld y lo guarda en `/logs/your-experiment-name/2a_f0`. 
Luego, convierte logarítmicamente la información de tono a un número entero entre 1 y 255 y lo guarda en `/logs/your-experiment-name/2b-f0nsf`.

### Extraer función_impresión (extract feature_print)
Convierte el archivo wav para incrustarlo de antemano usando HuBERT. Lee el archivo wav guardado en `/logs/your-experiment-name/1_16k_wavs`, convierta el archivo wav a funciones de 256 dimensiones con HuBERT y lo guarda en formato npy en `/logs/your-experiment-name/3_feature256`.

## paso 3
entrenar al modelo.
### Glosario para principiantes
En el aprendizaje profundo, el conjunto de datos se divide y el aprendizaje avanza poco a poco. En una actualización del modelo (step), se recuperan los datos de tamaño de lote (batch size) y se realizan predicciones y correcciones de errores. Hacer esto una vez para un conjunto de datos cuenta como una época.

Por lo tanto, el tiempo de aprendizaje es el tiempo de aprendizaje por paso x (la cantidad de datos en el conjunto de datos/tamaño del lote) x la cantidad de épocas.
En general, cuanto mayor es el tamaño del lote, más estable se vuelve el aprendizaje (tiempo de aprendizaje por paso ÷ tamaño del lote) se vuelve más pequeño, pero usa más memoria GPU.
La GPU RAM se puede verificar con el comando nvidia-smi. El aprendizaje se puede realizar en poco tiempo aumentando el tamaño del lote tanto como sea posible de acuerdo con la máquina del entorno de ejecución.

### Especificar modelo preentrenado
RVC comienza a entrenar el modelo a partir de pesos previamente entrenados en lugar de desde 0, por lo que se puede entrenar con un pequeño conjunto de datos.

Por defecto

- Si considera el tono, carga `rvc-ubicación/preentrenado/f0G40k.pth` y `rvc-ubicación/preentrenado/f0D40k.pth`.
- Si no considera el tono, carga `rvc-ubicación/preentrenado/f0G40k.pth` y `rvc-ubicación/preentrenado/f0D40k.pth`.

Al aprender, los parámetros del modelo se guardan en `logs/your-experiment-name/G_{}.pth` y `logs/your-experiment-name/D_{}.pth` para cada save_every_epoch, pero al especificar esta ruta, usted puede empezar a aprender. Puede reiniciar o comenzar a entrenar a partir de pesos modelo aprendidos en un experimento diferente. 

### índice de aprendizaje
RVC guarda los valores de características de HuBERT utilizados durante el entrenamiento y, durante la inferencia, busca valores de características que sean similares a los valores de características utilizados durante el aprendizaje para realizar inferencias. 
Para realizar esta búsqueda a alta velocidad, el índice se aprende de antemano.
Para el aprendizaje de índices, usamos el faiss de biblioteca de búsqueda de vecindario aproximado.

Lea el valor de la característica de `logs/your-experiment-name/3_feature256` y utilícelo para conocer el índice y guárdelo como `logs/your-experiment-name/add_XXX.index`.
(A partir de la versión de actualización 20230428, se lee del índice y ya no es necesario guardar/especificar).

### Descripción del botón
- Entrenar modelo: después de ejecutar el paso 2b, presione este botón para entrenar el modelo.
- Entrenar el índice de características: después de entrenar el modelo, realice el aprendizaje del índice.
- Entrenamiento con un clic: paso 2b, entrenamiento de modelos y entrenamiento de índice de características, todo a la vez.