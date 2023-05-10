@echo off 

echo el directorio de trabajo es %cd%
echo comprobando requisito para descargas aria2
echo=
dir /a:d/b | findstr "aria2" > flag.txt
findstr "aria2" flag.txt >nul
if %errorlevel% ==0 (
    echo aria2 verificado.
    echo=
) else (
    echo fallo. por favor descargue aria2 desde la pagina web!
    echo descomprimelo y colocalo en este directorio!
    timeout /T 5
    start https://github.com/aria2/aria2/releases/tag/release-1.36.0
    echo=
    goto end
)

echo iniciando verificacion de archivos de entorno.
echo=

for /f %%x in ('findstr /i /c:"aria2" "flag.txt"') do (set aria2=%%x)&goto endSch
:endSch

set d32=f0D32k.pth
set d40=f0D40k.pth
set d48=f0D48k.pth
set g32=f0G32k.pth
set g40=f0G40k.pth
set g48=f0G48k.pth

set dld32=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D32k.pth
set dld40=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D40k.pth
set dld48=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0D48k.pth
set dlg32=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G32k.pth
set dlg40=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G40k.pth
set dlg48=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/f0G48k.pth

set hp2=HP2-人声vocals+非人声instrumentals.pth
set hp5=HP5-主旋律人声vocals+其他instrumentals.pth

set dlhp2=https://huggingface.co/juuzouyt/rvc_voces/resolve/main/HP2.pth
set dlhp5=https://huggingface.co/juuzouyt/rvc_voces/resolve/main/HP5.pth

set hb=hubert_base.pt

set dlhb=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/hubert_base.pt

echo Iniciando verificacion de directorios.
echo=

if exist "%~dp0pretrained" (
        echo folder .\pretrained verificado.
    ) else (
        echo Fallo, generando folder .\pretrained.
        mkdir pretrained
    )
if exist "%~dp0uvr5_weights" (
        echo folder .\uvr5_weights verificado.
    ) else (
        echo Fallo, generando folder .\uvr5_weights.
        mkdir uvr5_weights
    )

echo=
echo verificacion de directorios finalizada.

echo=
echo iniciando verificacion de archivos requeridos.

echo verificando D32k.pth
if exist "%~dp0pretrained\D32k.pth" (
        echo D32k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D32k.pth -d %~dp0pretrained -o D32k.pth
        if exist "%~dp0pretrained\D32k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando D40k.pth
if exist "%~dp0pretrained\D40k.pth" (
        echo D40k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D40k.pth -d %~dp0pretrained -o D40k.pth
        if exist "%~dp0pretrained\D40k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
    echo verificando D48k.pth
if exist "%~dp0pretrained\D48k.pth" (
        echo D48k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/D48k.pth -d %~dp0pretrained -o D48k.pth
        if exist "%~dp0pretrained\D48k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
    echo verificando G32k.pth
if exist "%~dp0pretrained\G32k.pth" (
        echo G32k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G32k.pth -d %~dp0pretrained -o G32k.pth
        if exist "%~dp0pretrained\G32k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
    echo verificando G40k.pth
if exist "%~dp0pretrained\G40k.pth" (
        echo G40k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G40k.pth -d %~dp0pretrained -o G40k.pth
        if exist "%~dp0pretrained\G40k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
    echo verificando G48k.pth
if exist "%~dp0pretrained\G48k.pth" (
        echo G48k.pth en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main/pretrained/G48k.pth -d %~dp0pretrained -o G48k.pth
        if exist "%~dp0pretrained\G48k.pth" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )

echo verificando %d32%
if exist "%~dp0pretrained\%d32%" (
        echo %d32% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dld32% -d %~dp0pretrained -o %d32%
        if exist "%~dp0pretrained\%d32%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %d40%
if exist "%~dp0pretrained\%d40%" (
        echo %d40% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dld40% -d %~dp0pretrained -o %d40%
        if exist "%~dp0pretrained\%d40%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %d48%
if exist "%~dp0pretrained\%d48%" (
        echo %d48% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dld48% -d %~dp0pretrained -o %d48%
        if exist "%~dp0pretrained\%d48%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %g32%
if exist "%~dp0pretrained\%g32%" (
        echo %g32% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlg32% -d %~dp0pretrained -o %g32%
        if exist "%~dp0pretrained\%g32%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %g40%
if exist "%~dp0pretrained\%g40%" (
        echo %g40% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlg40% -d %~dp0pretrained -o %g40%
        if exist "%~dp0pretrained\%g40%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %g48%
if exist "%~dp0pretrained\%g48%" (
        echo %g48% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlg48% -d %~dp0\pretrained -o %g48%
        if exist "%~dp0pretrained\%g48%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )

echo verificando %hp2%
if exist "%~dp0uvr5_weights\%hp2%" (
        echo %hp2% en .\uvr5_weights verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlhp2% -d %~dp0\uvr5_weights -o %hp2%
        if exist "%~dp0uvr5_weights\%hp2%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )
echo verificando %hp5%
if exist "%~dp0uvr5_weights\%hp5%" (
        echo %hp5% en .\uvr5_weights verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlhp5% -d %~dp0\uvr5_weights -o %HP5%
        if exist "%~dp0uvr5_weights\%hp5%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )

echo verificando %hb%
if exist "%~dp0%hb%" (
        echo %hb% en .\pretrained verificado.
        echo=
    ) else (
        echo fallo. comenzando la descarga desde HuggingFace.
        %~dp0%aria2%\aria2c --console-log-level=error -c -x 16 -s 16 -k 1M %dlhb% -d %~dp0 -o %hb%
        if exist "%~dp0%hb%" (echo descarga exitosa.) else (echo por favor intentalo de nuevo!
        echo=)
    )

echo revision de archivos requeridos finalizada.
echo comprobacion de archivos de entorno completa.
pause
:end
del flag.txt