from django.shortcuts import render
from .models import Usuario
import requests
from django.conf import settings
from datetime import date
import re
from django.shortcuts import render, redirect
from .models import (
    Usuario,
    Persona,
    Directivo,
    Docente,
    Alumno,
    Preceptor,
    Tutor,
    PersonalAdministrativo
)

def obtener_persona(request):
    usuario_id = request.session.get('usuario_id')

    if not usuario_id:
        return None

    usuario = Usuario.objects.get(id=usuario_id)
    return Persona.objects.filter(id_usuario=usuario).first()

def index(request):
    usuario_datos = Usuario.objects.all()
    return render(request, 'core/index.html', {
        'usuarios': usuario_datos
    })

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

        if not telefono or not telefono.isdigit():
            return render(
                request,
                'core/inscripcion.html',
                {
                    'error': 'El teléfono debe contener únicamente números.'
                }
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
    if request.method == 'POST':
        usuario_input = request.POST.get('usuario')
        password = request.POST.get('password')

        try:
            usuario = Usuario.objects.get(
                nombre_usuario=usuario_input,
                contrasenia=password
            )

            request.session['usuario_id'] = usuario.id

            # 🔥 DETECTAR ROL POR TABLAS
            if PersonalAdministrativo.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-administrativo')

            elif Docente.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-docente')

            elif Tutor.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-padres')

            elif Preceptor.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-preceptor')

            elif Directivo.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-directivo')

            elif Alumno.objects.filter(id_persona__id_usuario=usuario).exists():
                return redirect('dashboard-alumno')

            else:
                return redirect('login')

        except Usuario.DoesNotExist:
            return render(request, 'core/login.html', {
                'error': 'Datos incorrectos'
            })

    return render(request, 'core/login.html')

def niveles(request):
    return render(request, 'core/niveles.html')

def noticias(request):
    return render(request, 'core/noticias.html')

def dashboard_alumno(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-alumno.html', {
        'persona': persona
    })

def dashboard_docente(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-docente.html', {
        'persona': persona
    })

def dashboard_directivo(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-directivo.html', {
        'persona': persona
    })

def dashboard_administrativo(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-administrativo.html', {
        'persona': persona
    })

def dashboard_padres(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-padres.html', {
        'persona': persona
    })

def dashboard_preceptor(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-preceptor.html', {
        'persona': persona
    })