from django.shortcuts import render
from .models import Usuario


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