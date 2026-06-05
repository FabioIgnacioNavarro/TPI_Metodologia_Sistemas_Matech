from django.shortcuts import render, redirect
from .models import Usuario
import requests
from django.conf import settings

def index(request):
    usuario_datos = Usuario.objects.all()
    return render(request, 'core/index.html', {
        'usuarios': usuario_datos
    })
    
def index(request):
    return render(request, 'core/index.html')

def bienestar(request):
    return render(request, 'core/bienestar.html')

def contacto(request):
    return render(request, 'core/contacto.html')

def inscripcion(request):

    if request.method == "POST":

        url = f"https://api.airtable.com/v0/{settings.AIRTABLE_BASE_ID}/{settings.AIRTABLE_TABLE_NAME}"

        headers = {
            "Authorization": f"Bearer {settings.AIRTABLE_TOKEN}",
            "Content-Type": "application/json"
        }

        data = {
            "fields": {
                "Nombre completo": request.POST.get("nombre"),
                "DNI": request.POST.get("dni"),
                "Fecha de nacimiento": request.POST.get("fecha"),
                "Nivel educativo": request.POST.get("nivel"),
                "Nombre del padre, madre o tutor": request.POST.get("tutor"),
                "Teléfono": request.POST.get("telefono"),
                "Correo electrónico": request.POST.get("email"),
                "Turno preferido": request.POST.get("turno"),
                "Observaciones": request.POST.get("observaciones"),
                "Estado": "Pendiente"
            }
        }

        print("TOKEN CONFIGURADO:", settings.AIRTABLE_TOKEN[:15])
        print("BASE:", settings.AIRTABLE_BASE_ID)
        print("TABLA:", settings.AIRTABLE_TABLE_NAME)
        print("HEADERS:", headers)

        respuesta = requests.post(
            url,
            json=data,
            headers=headers
        )

        print("STATUS:", respuesta.status_code)
        print("RESPUESTA:", respuesta.text)

        if respuesta.status_code in [200, 201]:
            return render(
                request,
                'core/inscripcion.html',
                {'exito': True}
            )

        return render(
            request,
            'core/inscripcion.html',
            {
                'error': respuesta.text
            }
        )

    return render(request, 'core/inscripcion.html')

def login(request):
    return render(request, 'core/login.html')

def niveles(request):
    return render(request, 'core/niveles.html')

def noticias(request):
    return render(request, 'core/noticias.html')

def dashboard_alumno(request):
    return render(request, 'core/dashboard-alumno.html')

def dashboard_docente(request):
    return render(request, 'core/dashboard-docente.html')

def dashboard_directivo(request):
    return render(request, 'core/dashboard-directivo.html')

def dashboard_administrativo(request):
    return render(request, 'core/dashboard-administrativo.html')

def dashboard_padres(request):
    return render(request, 'core/dashboard-padres.html')

def dashboard_preceptor(request):
    return render(request, 'core/dashboard-preceptor.html')