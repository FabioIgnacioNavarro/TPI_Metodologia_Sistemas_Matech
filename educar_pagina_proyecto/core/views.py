import requests
from django.conf import settings
from datetime import date
import re
from django.core.files.storage import FileSystemStorage
import os
from django.shortcuts import render, redirect

from .models import (
    Usuario,
    Persona,
    Directivo,
    Docente,
    Alumno,
    Preceptor,
    Tutor,
    TutorTutoraAlumno,
    PersonalAdministrativo,
    Noticia,
    Calificacion,
    Asistencia
)
import json
import os

OPINIONES_FILE = os.path.join(os.path.dirname(__file__), 'opiniones.json')

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
            
        patron_email = r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|outlook\.com)$'
        
        if not re.match(patron_email, email):
            return render(
                request,
                'core/inscripcion.html',
                {'error': 'Ingrese un correo electrónico válido (solo Gmail, Hotmail u Outlook).'}
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
        rol_input = request.POST.get('rol')

        if not rol_input:
            return render(request, 'core/login.html', {
                'error': 'Debe seleccionar un tipo de usuario.'
            })
        try:
            try:
                usuario = Usuario.objects.get(
                    nombre_usuario=usuario_input,
                    contrasenia=password
                )
            except Usuario.DoesNotExist:
                usuario = Usuario.objects.get(
                    correo=usuario_input,
                    contrasenia=password
                )

            # 🔥 DETECTAR ROL POR TABLAS
            redireccion = 'login'
            rol_correcto = False
            
            if rol_input == 'administrativo' and PersonalAdministrativo.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-administrativo'
                
            elif rol_input == 'docente' and Docente.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-docente'
                
            elif rol_input == 'padre' and Tutor.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-padres'
                
            elif rol_input == 'preceptor' and Preceptor.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-preceptor'
                
            elif rol_input == 'directivo' and Directivo.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-directivo'
                
            elif rol_input == 'alumno' and Alumno.objects.filter(id_persona__id_usuario=usuario).exists():
                rol_correcto = True
                redireccion = 'dashboard-alumno'

            if not rol_correcto:
                return render(request, 'core/login.html', {
                    'error': 'El tipo de usuario seleccionado no corresponde a esta cuenta.'
                })

            request.session['usuario_id'] = usuario.id
            return redirect(redireccion)
        except Usuario.DoesNotExist:
            return render(request, 'core/login.html', {
                'error': 'Datos incorrectos'
            })

    return render(request, 'core/login.html')

def niveles(request):
    return render(request, 'core/niveles.html')

def noticias(request):

    noticias = Noticia.objects.all().order_by('-fecha_publicacion')
    
    return render(
        request,
        'core/noticias.html',
        {
            'noticias': noticias
        }
    )

def dashboard_alumno(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    alumno = Alumno.objects.filter(
        id_persona=persona
    ).select_related('id_curso').first()

    noticias = Noticia.objects.all().order_by('-fecha_publicacion')
    ultimas_noticias = noticias[:3]

    calificaciones = Calificacion.objects.filter(
        legajo_alumno=alumno
    ).select_related('id_materia')

    asistencias = Asistencia.objects.filter(
        legajo_alumno=alumno
    ).order_by('-fecha')

    presentes = asistencias.filter(
        observacion__icontains='Presente'
    ).count()

    ausencias = asistencias.filter(
        observacion__icontains='Ausente'
    ).count()

    tardanzas = asistencias.filter(
        observacion__icontains='Tardanza'
    ).count()

    return render(request, 'core/dashboard-alumno.html', {
        'persona': persona,
        'alumno': alumno,
        'noticias': noticias,
        'ultimas_noticias': ultimas_noticias,
        'calificaciones': calificaciones,
        'asistencias': asistencias,
        'presentes': presentes,
        'ausencias': ausencias,
        'tardanzas': tardanzas
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

    tutor = Tutor.objects.filter(id_persona=persona).first()

    hijos = []
    if tutor:
        relaciones = TutorTutoraAlumno.objects.filter(id_tutor=tutor)
        hijos = [rel.id_alumno.id_persona for rel in relaciones]

    return render(request, 'core/dashboard-padres.html', {
        'persona': persona,
        'hijos': hijos
    })

def dashboard_preceptor(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    return render(request, 'core/dashboard-preceptor.html', {
        'persona': persona
    })

def crear_noticia(request):

    if request.method == 'POST':

        titulo = request.POST.get('titulo')
        contenido = request.POST.get('contenido')
        imagen = request.FILES.get('imagen')

        persona = obtener_persona(request)

        administrativo = PersonalAdministrativo.objects.filter(
            id_persona=persona
        ).first()

        if len(contenido) > 350:
            return render(
                request,
                'core/dashboard-administrativo.html',
                {
                    'error': 'La noticia no puede superar los 350 caracteres.'
                }
            )

        ruta_imagen = None

        if imagen:

            if imagen:

                fs = FileSystemStorage(
                    location=os.path.join(settings.MEDIA_ROOT, 'noticias')
                )

                nombre_archivo = fs.save(
                    imagen.name,
                    imagen
                )

                ruta_imagen = f'noticias/{nombre_archivo}'

        Noticia.objects.create(
            titulo=titulo,
            contenido=contenido,
            fecha_publicacion=date.today(),
            legajo_personal=administrativo,
            imagen=ruta_imagen
        )
        return redirect('dashboard-administrativo')

    return redirect('dashboard-administrativo')
    
def guardar_opinion(request):
    if request.method == 'POST':
        nombre = request.POST.get('nombre', '').strip() or 'Anónimo'
        opinion = request.POST.get('opinion', '').strip()

        # Validaciones básicas
        if not opinion:
            return render(request, 'core/contacto.html', {
                'error_opinion': 'La opinión no puede estar vacía.'
            })

        if len(opinion) > 500:
            return render(request, 'core/contacto.html', {
                'error_opinion': 'La opinión no puede superar los 500 caracteres.'
            })

        # Leer opiniones existentes
        if os.path.exists(OPINIONES_FILE):
            with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
                opiniones = json.load(f)
        else:
            opiniones = []

        # Agregar la nueva opinión
        from datetime import datetime
        opiniones.append({
            'nombre': nombre,
            'texto': opinion,
            'fecha': datetime.now().strftime('%d/%m/%Y %H:%M')
        })

        # Guardar en el archivo
        with open(OPINIONES_FILE, 'w', encoding='utf-8') as f:
            json.dump(opiniones, f, ensure_ascii=False, indent=2)

        return redirect('contacto')

    return redirect('contacto')

def contacto(request):
    # Leer opiniones del archivo para mostrarlas
    if os.path.exists(OPINIONES_FILE):
        with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
            opiniones = json.load(f)
    else:
        opiniones = []

    return render(request, 'core/contacto.html', {
        'opiniones': opiniones
    })
