<div align="center">

<h1>Retrieval-based-Voice-Conversion-WebUI</h1>
Un marco de transformación de voz (modulador de voz) simple y fácil de usar basado en VITS.<br><br>

[![madewithlove](https://forthebadge.com/images/badges/built-with-love.svg)](https://github.com/liujing04/Retrieval-based-Voice-Conversion-WebUI)

<img src="https://counter.seku.su/cmoe?name=rvc&theme=r34" /><br>

[![Open In Colab](https://img.shields.io/badge/Colab-F9AB00?style=for-the-badge&logo=googlecolab&color=525252)](https://colab.research.google.com/github/liujing04/Retrieval-based-Voice-Conversion-WebUI/blob/main/Retrieval_based_Voice_Conversion_WebUI.ipynb)
[![Licence](https://img.shields.io/github/license/liujing04/Retrieval-based-Voice-Conversion-WebUI?style=for-the-badge)](https://github.com/liujing04/Retrieval-based-Voice-Conversion-WebUI/blob/main/%E4%BD%BF%E7%94%A8%E9%9C%80%E9%81%B5%E5%AE%88%E7%9A%84%E5%8D%8F%E8%AE%AE-LICENSE.txt)
[![Huggingface](https://img.shields.io/badge/🤗%20-Spaces-yellow.svg?style=for-the-badge)](https://huggingface.co/lj1995/VoiceConversionWebUI/tree/main/)

[![Discord](https://img.shields.io/badge/RVC%20Developers-Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/HcsmBBGyVk)

</div>

------

[Registro de actualizaciones](https://github.com/liujing04/Retrieval-based-Voice-Conversion-WebUI/blob/main/Changelog_CN.md)

[**English**](./docs/README.en.md) | [**Español**](./README.md) | [**日本語**](./docs/README.ja.md) | [**한국어**](./docs/README.ko.md)


Estas instrucciones deben ejecutarse en un entorno de Python con una versión superior a 3.8:
```bash
# Instalar Pytorch y sus dependencias principales, si ya están instalados, omitir.
# Referencia: https://pytorch.org/get-started/locally/
pip install torch torchvision torchaudio

# Si estás utilizando el sistema operativo Windows y la arquitectura Nvidia Ampere (RTX30xx), es necesario especificar la versión correspondiente de PyTorch para CUDA.
# pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
```

Puedes instalar las dependencias a través de pip:

**Nota**: La versión `1.7.2 de faiss` en MacOS puede generar errores de segmentación. Al instalar manualmente, utilice el comando `pip install faiss-cpu==1.7.0` para especificar la versión `1.7.0`.

```bash
pip install -r requirements.txt
```

## Preparación de otros modelos previos
RVC necesita otros modelos previos para inferir y entrenar.

Puedes descargar estos modelos desde [hugginface](https://huggingface.co/lj1995/VoiceConversionWebUI/tree/main/).


Aquí hay una lista que incluye los nombres de los modelos previos y otros archivos necesarios para RVC:
```bash
hubert_base.pt

./pretrained 

./uvr5_weights

#Si está utilizando Windows, es posible que necesite estos archivos. Si ya tiene instalados ffmpeg y ffprobe, puede omitir estas línea. Los usuarios de ubuntu/debian pueden instalar estas dos bibliotecas con el comando apt install ffmpeg.
./ffmpeg

./ffprobe
```
Si tiene windows puede ejecutar el archivo `envfilescheck.bat` para descargar los modelos automaticamente, necesitará descargar [aria2] y decomprimirlo en el folder de RVC (https://github.com/aria2/aria2/archive/refs/tags/release-1.36.0.zip).




Después, usa los siguientes comandos para iniciar la interfaz web:
```bash
python infer-web.py
```


Hay una copia del documento "Guía básica para principiantes.doc" en el folder "docs" para que lo revise.

## Proyectos de referencia
+ [ContentVec](https://github.com/auspicious3000/contentvec/)
+ [VITS](https://github.com/jaywalnut310/vits)
+ [HIFIGAN](https://github.com/jik876/hifi-gan)
+ [Gradio](https://github.com/gradio-app/gradio)
+ [FFmpeg](https://github.com/FFmpeg/FFmpeg)
+ [Ultimate Vocal Remover](https://github.com/Anjok07/ultimatevocalremovergui)
+ [audio-slicer](https://github.com/openvpi/audio-slicer)

## Agradecemos los esfuerzos realizados por todos los contribuyentes.
<a href="https://github.com/liujing04/Retrieval-based-Voice-Conversion-WebUI/graphs/contributors" target="_blank">
  <img src="https://contrib.rocks/image?repo=liujing04/Retrieval-based-Voice-Conversion-WebUI" />
</a>
