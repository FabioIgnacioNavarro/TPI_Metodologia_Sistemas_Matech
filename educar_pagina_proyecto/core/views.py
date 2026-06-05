from django.shortcuts import render
from .models import Usuario
import requests
from django.conf import settings
from datetime import date
import re


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

    if request.method == 'POST':

        url = f"https://api.airtable.com/v0/{settings.AIRTABLE_BASE_ID}/{settings.AIRTABLE_TABLE_NAME}"

        headers = {
            "Authorization": f"Bearer {settings.AIRTABLE_TOKEN}",
            "Content-Type": "application/json"
        }
        
        nombre = request.POST.get('nombre')
        dni = request.POST.get('dni')
        fecha = request.POST.get('fecha')
        email = request.POST.get('email')

        if not nombre or not dni or not fecha or not email:
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'Todos los campos obligatorios deben completarse.'}
            )
            
        if not dni.isdigit():
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'El DNI debe contener únicamente números.'}
            )
            
        telefono = request.POST.get('telefono')
        if not telefono.isdigit():
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'El teléfono debe contener únicamente números.'}
            )
            
        patron_email = r'^[\w\.-]+@[\w\.-]+\.\w+$'

        if not re.match(patron_email, email):
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'Ingrese un correo electrónico válido.'}
            )

        fecha_nacimiento = date.fromisoformat(fecha)

        if fecha_nacimiento > date.today():
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'La fecha de nacimiento no puede ser futura.'}
            )
            
        edad = date.today().year - fecha_nacimiento.year
        nivel = nivel = request.POST.get('nivel')
        
        if nivel == 'primario' and (edad < 5 or edad > 15):
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'La edad no corresponde al nivel primario.'}
            )

        if nivel == 'secundario' and (edad < 11 or edad > 20):
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'La edad no corresponde al nivel secundario.'}
            )

        if nivel == 'inicial' and edad > 6:
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'La edad no corresponde al nivel inicial.'}
            )
        
        
        
        data = {
            "fields": {
                "Nombre completo": request.POST.get('nombre'),
                "DNI": request.POST.get('dni'),
                "Fecha de nacimiento": request.POST.get('fecha'),
                "Nivel educativo": request.POST.get('nivel'),
                "Nombre del padre, madre o tutor": request.POST.get('tutor'),
                "Teléfono": request.POST.get('telefono'),
                "Correo electrónico": request.POST.get('email'),
                "Turno preferido": request.POST.get('turno'),
                "Observaciones": request.POST.get('observaciones'),
                "Estado": "Pendiente"
            }
        }

        respuesta = requests.post(
            url,
            headers=headers,
            json=data
        )

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

    return render(
        request,
        'core/inscripcion.html'
    )

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