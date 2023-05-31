#@title <font color="#018ada">Paso 3b. Cargar modelo desde url muy usada (Permiso de lectura y escritura avanzada en drive - OPCIONAL) - (inferencia/entrenamiento)</font>
#@markdown **Nota:** Si el modelo pesa más de 2gb puede tardar hasta 5 minutos
import os
import shutil
from urllib.parse import urlparse, parse_qs, urlunparse
import time
import ipywidgets as widgets
success=widgets.Button(description="\u2714 Hecho",disabled=True, button_style="success")

os.chdir(os.path.expanduser("~"))

def crear_acceso_directo(enlace):
        if os.path.exists('/content/drive/MyDrive/temporalmodels'):
          shutil.rmtree('/content/drive/MyDrive/temporalmodels')

        # Obtiene el ID del archivo desde el enlace
        id_archivo = enlace.split('/')[-2]
        
        # Busca la carpeta "tempmodel"
        carpeta_models = gdrive.ListFile({'q': "title='temporalmodels' and mimeType='application/vnd.google-apps.folder' and trashed=false"}).GetList()
        
        # Si la carpeta "temporalmodels" no existe, la crea
        nueva_carpeta = gdrive.CreateFile({
            'title': 'temporalmodels',
            'mimeType': 'application/vnd.google-apps.folder'
        })
        nueva_carpeta.Upload()
        carpeta_models_id = nueva_carpeta['id']

        # Verifica si ya existe un acceso directo con el mismo nombre
        acceso_directo_existente = gdrive.ListFile({'q': f"title='tempmodel' and '{carpeta_models_id}' in parents and mimeType='application/vnd.google-apps.shortcut' and trashed=false"}).GetList()
        
        if len(acceso_directo_existente) > 0:
            # Si ya existe un acceso directo con el mismo nombre, lo reemplaza
            acceso_directo = acceso_directo_existente[0]
            acceso_directo['shortcutDetails'] = {'targetId': id_archivo}
            acceso_directo.Upload()
        else:
            # Si no existe un acceso directo con el mismo nombre, lo crea
            enlace_simbolico = gdrive.CreateFile({
                'mimeType': 'application/vnd.google-apps.shortcut',
                'shortcutDetails': {
                    'targetId': id_archivo
                },
                'parents': [{'id': carpeta_models_id}]
            })
            enlace_simbolico.Upload()
            enlace_simbolico.FetchMetadata() 

def format_google_drive_url(url):
    parsed_url = urlparse(url)

    # Verificar si la URL ya está en el formato deseado
    if '/file/d/' in parsed_url.path and '/view' in parsed_url.path:
        return url

    # Extraer el ID del archivo
    query_params = parse_qs(parsed_url.query)
    file_id = query_params.get('id', [''])[0]

    # Crear los nuevos componentes de la URL
    new_path = f'/file/d/{file_id}/view'
    new_query = 'usp=sharing'

    # Actualizar los componentes de la URL
    parsed_url = parsed_url._replace(path=new_path, query=new_query)

    # Generar la URL formateada
    formatted_url = urlunparse(parsed_url)

    return formatted_url

def download_from_drive_url(url):
    print("Creando acceso directo...")

    # Ejemplo de uso
    url = format_google_drive_url(url)
    print(url)

    crear_acceso_directo(url)

    while not os.path.exists("/content/drive/MyDrive/temporalmodels"):
        time.sleep(1)

    if os.path.exists("/content/tempfolder"):
        shutil.rmtree("/content/tempfolder")
    if os.path.exists("/content/Models"):
        shutil.rmtree("/content/Models")

    os.mkdir("/content/tempfolder")
    os.mkdir("/content/Models")
    print("Comprimiendo archivo (Esto puede tomar unos minutos)...")
    #Comprimir el acceso directo en /content/tempfolder/xxx.zip
    shutil.make_archive(f"/content/tempfolder/xxx", "zip", "/content/drive/MyDrive/temporalmodels") 
    print(f"Copiando a /content/Models...")
    #Descomprimir el archivo /content/tempfolder/xxx.zip en /content/Models/
    shutil.unpack_archive(f"/content/tempfolder/xxx.zip", f"/content/Models")

    directorio1 = "/content/drive/MyDrive/Models"
    directorio2 = "/content/drive/MyDrive/temporalmodels"
    try:
        shutil.rmtree(directorio1)
        print("Directorio 'Models' eliminado exitosamente.")
    except FileNotFoundError:
        print("El directorio 'Models' no existe, omitiendo.")
    except Exception as e:
        print("Ocurrió un error al eliminar el directorio 'Models':", str(e))

    try:
        shutil.rmtree(directorio2)
        print("Directorio 'temporalmodels' eliminado exitosamente.")
    except FileNotFoundError:
        print("El directorio 'temporalmodels' no existe, omitiendo.")
    except Exception as e:
        print("Ocurrió un error al eliminar el directorio 'temporalmodels':", str(e))

    # Obtener una lista de todos los archivos en el directorio
    models = os.listdir("/content/Models")
    models_zip = [archivo for archivo in models if archivo.endswith(".zip")]

    for MODELNAME in models_zip:
        print("Cargando modelo...")
        MODELNAME = MODELNAME.replace(".zip","")
        
        # Directorio donde se descomprimió el archivo
        dest_path = os.path.join("/content/RVC/logs/", MODELNAME)
        if os.path.exists(dest_path):
            # Si el archivo ya existe, eliminarlo
            shutil.rmtree(dest_path)
        try:
            os.mkdir(dest_path)
        except FileExistsError:
            pass
        except Exception as e:
            print("Ocurrió un error al crear el directorio:", str(e))

        zip_file = os.path.join('/content/Models', MODELNAME + ".zip")
        unzipped_dir = os.path.join("/content/unzips", MODELNAME)

        # Eliminar el directorio de destino si ya existe
        if os.path.exists(unzipped_dir):
            shutil.rmtree(unzipped_dir)
        # Descomprimir el archivo ZIP utilizando el nombre MODELNAME
        shutil.unpack_archive(zip_file, extract_dir="/content/unzips/" +  MODELNAME, format='zip')

        # Directorio donde se moverán los folders
        logs_dir = os.path.join('/content/RVC/logs', MODELNAME)
        weights_dir = '/content/RVC/weights'
        logs_folders = ['0_gt_wavs','1_16k_wavs','2a_f0','2b-f0nsf','3_feature256']

        index_file = False
        model_file = False
        D_file = False
        G_file = False

        model_name = MODELNAME
        # Mover el archivo D, G y added_*.index
        for path, subdirs, files in os.walk(unzipped_dir):
            for item in files:
                item_path = os.path.join(path, item)
                if not 'G_' in item and not 'D_' in item and item.endswith('.pth'):
                    model_file = True
                    model_name = item.replace(".pth","")
                    shutil.rmtree(logs_dir)
                    logs_dir = f"/content/RVC/logs/{model_name}"
                    os.mkdir(logs_dir)
                    if not os.path.exists(weights_dir):
                        os.mkdir(weights_dir)
                    if os.path.exists(os.path.join(weights_dir, item)):
                        os.remove(os.path.join(weights_dir, item))  
                    if os.path.exists(item_path):
                        shutil.move(item_path, weights_dir)

        # Mover el model.pth y renombrar folder
        for path, subdirs, files in os.walk(unzipped_dir):
            for item in files:
                item_path = os.path.join(path, item)
                if item.startswith('added_') and item.endswith('.index'):
                    index_file = True
                    if os.path.exists(item_path):
                        shutil.move(item_path, logs_dir)
                if 'D_' in item and item.endswith('.pth'):
                    D_file = True
                    if os.path.exists(item_path):
                        shutil.move(item_path, logs_dir)
                if 'G_' in item and item.endswith('.pth'):
                    G_file = True
                    if os.path.exists(item_path):
                        shutil.move(item_path, logs_dir)
                if item.startswith('total_fea.npy'):
                    if os.path.exists(item_path):
                        shutil.move(item_path, logs_dir)
                
        # Mover todos los folders excepto 'eval'
        for path, subdirs, files in os.walk(unzipped_dir):
            for folder in subdirs:
                if folder in logs_folders:
                    item_path = os.path.join(path, folder)
                    shutil.move(item_path, logs_dir)
        try:
            shutil.rmtree("/content/Models")
            print("Directorio 'Models' eliminado exitosamente.")
        except FileNotFoundError:
            print("El directorio 'Models' no existe.")
        except Exception as e:
            print("Ocurrió un error al eliminar el directorio 'Models':", str(e))

        try:
            os.rmdir("/content/tempfolder")
            print("Directorio 'tempfolder' eliminado exitosamente.")
        except FileNotFoundError:
            print("El directorio 'tempfolder' no existe.")
        except OSError as e:
            print("Ocurrió un error al eliminar el directorio 'tempfolder':", str(e))

        directorio_unzips = "/content/unzips"
        directorio_zips = "/content/zips"

        try:
            os.rmdir(directorio_unzips)
            print("Directorio 'unzips' eliminado exitosamente.")
        except FileNotFoundError:
            print("El directorio 'unzips' no existe.")
        except OSError as e:
            print("Ocurrió un error al eliminar el directorio 'unzips':", str(e))

        try:
            shutil.rmtree(directorio_zips)
            print("Directorio 'zips' eliminado exitosamente.")
        except FileNotFoundError:
            print("El directorio 'zips' no existe.")
        except Exception as e:
            print("Ocurrió un error al eliminar el directorio 'zips':", str(e))

        if model_file:
            if index_file:
                return "El modelo funciona para inferencia, y tiene el archivo .index"
            else:
                return "El modelo funciona para inferencia, pero no tiene el archivo .index"
        if D_file and G_file:
            return "El modelo puede ser reentrenado."