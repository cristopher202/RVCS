pip install --upgrade setuptools wheel
pip install --upgrade pip
pip install faiss-gpu fairseq gradio ffmpeg ffmpeg-python praat-parselmouth pyworld numpy==1.23.5 numba==0.56.4 librosa==0.9.2
pip install mega.py --quiet
pip install gdown --quiet

aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D32k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o D32k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D40k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o D40k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D48k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o D48k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G32k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o G32k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G40k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o G40k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G48k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o G48k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D32k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0D32k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D40k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0D40k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D48k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0D48k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G32k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0G32k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G40k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0G40k.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G48k.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\pretrained -o f0G48k.pth

aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/uvr5_weights/HP2-人声vocals+非人声instrumentals.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI/uvr5_weights -o HP2-人声vocals+非人声instrumentals.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/uvr5_weights/HP5-主旋律人声vocals+其他instrumentals.pth -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI/uvr5_weights -o HP5-主旋律人声vocals+其他instrumentals.pth
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/hubert_base.pt -d C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI -o hubert_base.pt

mkdir C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\RVC
mkdir C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\dataset
mkdir C:\Users\admin\Downloads\IA\Retrieval-based-Voice-Conversion-WebUI\EasyDataset
mkdir -p pretrained uvr5_weights