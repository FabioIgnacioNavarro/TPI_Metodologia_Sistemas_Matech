import requests
import re
from django.core.files.storage import FileSystemStorage
from datetime import datetime, date
from django.conf import settings
from datetime import date
from datetime import datetime
from django.shortcuts import redirect
from django.urls import reverse
import re
from django.core.files.storage import FileSystemStorage
import os
from django.shortcuts import render, redirect
from django.db.models import Avg
import json
from django.core.mail import EmailMessage
from django.contrib import messages
from django.utils import timezone
from datetime import date
from django.views.decorators.cache import never_cache
from .models import (
    Inscripcion,
    Materia,
    Curso,
    Usuario,
    Persona,
    Directivo,
    Docente,
    Alumno,
    Preceptor,
    Curso,
    Tutor,
    TutorTutoraAlumno,
    PersonalAdministrativo,
    Noticia,
    Calificacion,
    Asistencia,
    CursoCursaMaterias,
    DocenteDictaMateria,
    Reserva,
    Instalacion,
    Persona,
    Cuota,
    PostulacionLaboral,
    SolicitudInscripcion
)
COMUNICADOS_FILE = os.path.join(
    os.path.dirname(__file__),
    'comunicados.json'
)
import json
import os
from django.db.models import Avg
from django.views.decorators.cache import never_cache

OPINIONES_FILE = os.path.join(os.path.dirname(__file__), 'opiniones.json')

def obtener_persona(request):
    usuario_id = request.session.get('usuario_id')

    if not usuario_id:
        return None

    usuario = Usuario.objects.get(id=usuario_id)
    return Persona.objects.filter(id_usuario=usuario).first()

def index(request):
    usuario_datos = Usuario.objects.all()
    persona, dashboard_url = obtener_datos_sesion(request)
    return render(request, 'core/index.html', {
        'usuarios': usuario_datos,
        'persona': persona,
        'dashboard_url': dashboard_url
    })

def bienestar(request):
    persona, dashboard_url = obtener_datos_sesion(request)
    return render(request, 'core/bienestar.html', {
        'persona': persona,
        'dashboard_url': dashboard_url
    })

def contacto(request):
    opiniones = []

    if os.path.exists(OPINIONES_FILE):
        try:
            with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
                contenido = f.read().strip()

                if contenido:
                    opiniones = json.loads(contenido)

        except (json.JSONDecodeError, FileNotFoundError):
            opiniones = []

    persona, dashboard_url = obtener_datos_sesion(request)

    return render(request, 'core/contacto.html', {
        'opiniones': opiniones,
        'persona': persona,
        'dashboard_url': dashboard_url
    })

def inscripcion(request):
    # 1. Obtenemos los datos de sesión al inicio de la función
    persona, dashboard_url = obtener_datos_sesion(request)

    if request.method == 'POST':

        SolicitudInscripcion.objects.create(
            nombre_alumno=request.POST.get('nombre'),
            apellido_alumno=request.POST.get('apellido'),
            dni_alumno=request.POST.get('dni'),
            fecha_nacimiento=request.POST.get('fecha'),
            direccion=request.POST.get('direccion'),
            telefono_alumno=request.POST.get('telefono_alumno'),
            email_alumno=request.POST.get('email_alumno'),

            nivel=request.POST.get('nivel'),
            turno=request.POST.get('turno'),

            nombre_tutor=request.POST.get('tutor'),
            apellido_tutor=request.POST.get('apellido_tutor'),
            dni_tutor=request.POST.get('dni_tutor'),

            parentesco=request.POST.get('parentesco'),

            telefono=request.POST.get('telefono'),
            email=request.POST.get('email'),
            
            direccion_tutor=request.POST.get("direccion_tutor"),

            observaciones=request.POST.get('observaciones'),

            fecha_solicitud=timezone.now(),

            estado='Pendiente'
        )

        return render(
            request,
            'core/inscripcion.html',
            {
                'exito': True,
                'persona': persona,
                'dashboard_url': dashboard_url
            }
        )

    return render(
        request,
        'core/inscripcion.html',
        {
            'persona': persona,
            'dashboard_url': dashboard_url
        }
    )

@never_cache
def login(request):
    persona, dashboard_url = obtener_datos_sesion(request)
    if persona and dashboard_url and dashboard_url != 'login':
        return redirect(dashboard_url)

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

@never_cache
def niveles(request):
    persona, dashboard_url = obtener_datos_sesion(request)
    return render(request, 'core/niveles.html', {
        'persona': persona,
        'dashboard_url': dashboard_url
    })

def noticias(request):
    noticias = Noticia.objects.all().order_by('-id_noticia')
    persona, dashboard_url = obtener_datos_sesion(request)
    return render(request, 'core/noticias.html', {
        'noticias': noticias,
        'persona': persona,
        'dashboard_url': dashboard_url
    })

@never_cache
def dashboard_alumno(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    alumno = Alumno.objects.filter(
        id_persona=persona
    ).select_related('id_curso').first()

    curso_alumno = f"{alumno.id_curso.nivel} {alumno.id_curso.anio}° {alumno.id_curso.comision}"
    
    materias = CursoCursaMaterias.objects.filter(
        id_curso=alumno.id_curso
    ).select_related('id_materia')
    
    # Procesar horarios para mostrar en el panel
    # Inicializar días en orden
    horario_por_dia = {
        'lunes': [],
        'martes': [],
        'miércoles': [],
        'jueves': [],
        'viernes': []
    }

    # Función para normalizar nombres de días (maneja variantes sin tilde)
    def _normalize_dia(dia_raw):
        d = dia_raw.strip().lower()
        if d in ('miercoles', 'miercoles'):
            return 'miércoles'
        if d == 'miercoles':
            return 'miércoles'
        # cubrir otras variantes comunes
        mapping = {
            'lunes': 'lunes',
            'martes': 'martes',
            'miércoles': 'miércoles',
            'miercoles': 'miércoles',
            'jueves': 'jueves',
            'viernes': 'viernes'
        }
        return mapping.get(d, d)

    # Llenar con datos de las materias
    for materia in materias:
        if materia.horarios:
            try:
                horarios = json.loads(materia.horarios)

                # Crear formato legible
                horario_items = []
                for dia, hora in horarios.items():
                    dia_norm = _normalize_dia(dia)
                    horario_items.append(f"{dia_norm.capitalize()}: {hora}")

                    # Agregar a la lista de horarios por día si corresponde
                    if dia_norm in horario_por_dia:
                        horario_por_dia[dia_norm].append({
                            'materia': materia.id_materia.nombre,
                            'hora': hora
                        })

                materia.horario_formateado = " | ".join(horario_items)

            except Exception:
                materia.horario_formateado = str(materia.horarios)
        else:
            materia.horario_formateado = "Sin horario"
            
    alumno = Alumno.objects.filter(
        id_persona=persona
    ).select_related('id_curso').first()
    
    tutor_relacion = TutorTutoraAlumno.objects.filter(
        id_alumno=alumno
    ).select_related(
        'id_tutor',
        'id_tutor__id_persona'
    ).first()

    
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

    # Porcentaje de asistencia (presente / total registros)
    total_asistencias = presentes + ausencias + tardanzas
    if total_asistencias > 0:
        asistencia_pct = round((presentes / total_asistencias) * 100)
    else:
        asistencia_pct = 0

    # Agrupar calificaciones por materia para el panel de notas
    from collections import OrderedDict

    notas_resumen = []
    # Iterar por las materias asignadas al curso
    for curso_materia in materias:
        mat = curso_materia.id_materia
        califs_mat = calificaciones.filter(id_materia=mat).order_by('fecha')

        trim1 = ''
        trim2 = ''
        numeric_notes = []
        estado = ''

        for idx, c in enumerate(califs_mat):
            display_val = ''
            if c.nota is not None:
                display_val = float(c.nota)
            else:
                display_val = c.tipo_evaluacion or ''

            if idx == 0:
                trim1 = display_val
            elif idx == 1:
                trim2 = display_val

            if c.nota is not None:
                try:
                    numeric_notes.append(float(c.nota))
                except Exception:
                    pass

            if c.tipo_evaluacion and 'aprob' in c.tipo_evaluacion.lower():
                estado = 'Aprobado'

        promedio_mat = round(sum(numeric_notes) / len(numeric_notes), 2) if numeric_notes else ''

        notas_resumen.append({
            'materia': mat.nombre,
            'trim1': trim1,
            'trim2': trim2,
            'promedio': promedio_mat,
            'estado': estado or 'En curso'
        })

    # Promedio general del alumno (promedio de todas las calificaciones numéricas)
    all_numeric = [float(c.nota) for c in calificaciones if c.nota is not None]
    promedio_general = round(sum(all_numeric) / len(all_numeric), 1) if all_numeric else 0

    # Materias aprobadas: sólo se cuentan si hay un registro cuyo tipo indica 'Aprobado'
    materias_aprobadas = sum(1 for n in notas_resumen if n.get('estado') == 'Aprobado')
    total_materias = len(notas_resumen)
    COMUNICADOS_FILE = os.path.join(
        settings.BASE_DIR,
        "core",
        "comunicados.json"
    )

    comunicados_alumno = []
    ultimos_comunicados = []

    if os.path.exists(COMUNICADOS_FILE):
        try:
            with open(COMUNICADOS_FILE, 'r', encoding='utf-8') as f:
                file_content = f.read().strip()
                comunicados = json.loads(file_content) if file_content else []

                comunicados_alumno = [
                    c for c in comunicados
                    if (
                        c.get('rol') == 'Directivo'
                        or (
                            c.get('rol') == 'Preceptor'
                            and c.get('curso', '').strip().lower() == curso_alumno.strip().lower()
                        )
                    )
                ]

                # 🔥 ORDEN MÁS NUEVOS PRIMERO
                comunicados_alumno.reverse()

            # 🔥 últimos 3 ya ordenados
            ultimos_comunicados = comunicados_alumno[:3]

        except json.JSONDecodeError:
            comunicados_alumno = []
            ultimos_comunicados = []
    panel_activo = request.session.pop("panel_activo", "inicio")
    return render(request, 'core/dashboard-alumno.html', {
        'persona': persona,
        'alumno': alumno,
        'comunicados': comunicados_alumno,
        'ultimas_noticias': ultimos_comunicados,
        'calificaciones': calificaciones,
        'asistencias': asistencias,
        'presentes': presentes,
        'ausencias': ausencias,
        'tardanzas': tardanzas,
        'promedio_general': promedio_general,
        'asistencia_pct': asistencia_pct,
        'materias_aprobadas': materias_aprobadas,
        'total_materias': total_materias,
        'notas_resumen': notas_resumen,
        'materias': materias,
        'tutor_relacion': tutor_relacion,
        'horario_por_dia': horario_por_dia,
        "panel_activo": panel_activo,
    })

@never_cache
def dashboard_docente(request):
    from django.db.models import Avg

    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    docente = Docente.objects.filter(id_persona=persona).first()

    if not docente:
        return redirect('login')

    materias = Materia.objects.filter(
        docentedictamateria__id_docente=docente
    ).distinct()

    cursos = Curso.objects.filter(
        cursocursamaterias__id_materia__in=materias
    ).distinct()

    alumnos = Alumno.objects.filter(
        id_curso__in=cursos
    ).distinct()

    # 🔥 1. calificaciones
    calificaciones = Calificacion.objects.filter(
        id_materia__in=materias,
        legajo_alumno__in=alumnos
    ).select_related('id_materia', 'legajo_alumno')

    # 🔥 2. diccionario de notas
    notas_por_alumno = {}

    for c in calificaciones:
        alumno_id = c.legajo_alumno_id

        if alumno_id not in notas_por_alumno:
            notas_por_alumno[alumno_id] = []

        notas_por_alumno[alumno_id].append(c)

    # 🔥 3. cursos
    cursos_data = []

    for curso in cursos:
        alumnos_count = Alumno.objects.filter(id_curso=curso).count()

        promedio = Calificacion.objects.filter(
            legajo_alumno__id_curso=curso
        ).aggregate(prom=Avg('nota'))['prom']

        cursos_data.append({
            'curso': getattr(curso, 'comision', str(curso)),
            'nivel': getattr(curso, 'nivel', ''),
            'turno': getattr(curso, 'turno', ''),
            'alumnos': alumnos_count,
            'promedio': round(promedio, 1) if promedio else 0,
        })

    # 🔥 4. horarios (CORREGIDO PARA JSON)
    horarios = CursoCursaMaterias.objects.filter(
        id_materia__in=materias
    ).select_related('id_curso', 'id_materia')

    horario_dict = {}

    for h in horarios:
        data = h.horarios

        if isinstance(data, str):
            data = json.loads(data)

        for dia, rango in data.items():
            if rango not in horario_dict:
                horario_dict[rango] = {
                    'Lunes': '-',
                    'Martes': '-',
                    'Miércoles': '-',
                    'Jueves': '-',
                    'Viernes': '-',
                }

            dia_cap = dia.capitalize()

            if dia_cap == 'Miercoles':
                dia_cap = 'Miércoles'

            horario_dict[rango][dia_cap] = f"{h.id_curso.anio}° {h.id_curso.nivel} ({h.id_curso.comision}) - {h.id_curso.turno}"

    # 🔥 ordenar
    horario_ordenado = dict(sorted(horario_dict.items()))

    return render(request, 'core/dashboard-docente.html', {
        'persona': persona,
        'docente': docente,
        'materias': materias,
        'cursos': cursos_data,
        'alumnos': alumnos,
        'calificaciones': calificaciones,
        'notas_por_alumno': notas_por_alumno,
        'horario': horario_dict,
    })


def horario_docente(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    docente = Docente.objects.filter(id_persona=persona).first()

    if not docente:
        return redirect('login')

    materias = Materia.objects.filter(
        docentedictamateria__id_docente=docente
    ).distinct()

    cursos = CursoCursaMaterias.objects.filter(
        id_materia__in=materias
    )

    horario = {}

    for c in cursos:
        data = c.horarios

        if isinstance(data, str):
            data = json.loads(data)

        for dia, rango in data.items():
            if rango not in horario:
                horario[rango] = {
                    "Lunes": "-",
                    "Martes": "-",
                    "Miércoles": "-",
                    "Jueves": "-",
                    "Viernes": "-"
                }

            dia_cap = dia.capitalize()

            if dia_cap == "Miercoles":
                dia_cap = "Miércoles"

            horario[rango][dia_cap] = c.id_curso.comision

    return render(request, "tu_template.html", {
        "horario": horario
    })





@never_cache
def dashboard_directivo(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    cantidad_alumnos = Alumno.objects.count()
    cantidad_docentes = Docente.objects.count()
    cantidad_preceptores = Preceptor.objects.count()
    cantidad_administrativos = PersonalAdministrativo.objects.count()

    promedio_institucional = (
        Calificacion.objects.aggregate(
            promedio=Avg('nota')
        )['promedio'] or 0
    )

    ultimas_noticias = Noticia.objects.order_by(
        '-fecha_publicacion'
    )[:5]
    docentes = []

    relaciones = (
        DocenteDictaMateria.objects
        .select_related(
            'id_docente__id_persona',
            'id_materia'
        )
    )

    for relacion in relaciones[:10]:
        docente = relacion.id_docente
        materia = relacion.id_materia

        curso_materia = (
            CursoCursaMaterias.objects
            .filter(id_materia=materia)
            .select_related('id_curso')
            .first()
        )

        nivel = (
            curso_materia.id_curso.nivel
            if curso_materia
            else '-'
        )
        docentes.append({
        'nombre': f'{docente.id_persona.nombre} {docente.id_persona.apellido}',
        'materia': materia.nombre,
        'nivel': nivel,
        })
    return render(
        request,
        'core/dashboard-directivo.html',
        {
            'persona': persona,
            'cantidad_alumnos': cantidad_alumnos,
            'cantidad_docentes': cantidad_docentes,
            'cantidad_preceptores': cantidad_preceptores,
            'cantidad_administrativos': cantidad_administrativos,
            'promedio_institucional': round(promedio_institucional, 1),
            'ultimas_noticias': ultimas_noticias,
            'docentes': docentes
        }
    )
    
def postulacion(request):
    return render(request, 'core/postulacion.html')

@never_cache
def enviar_postulacion(request):
    
    nombre = request.POST.get("nombre", "").strip()
    apellido = request.POST.get("apellido", "").strip()
    dni = request.POST.get("dni", "").strip()
    correo_postulante = request.POST.get("correo", "").strip()
    telefono = request.POST.get("telefono", "").strip()

    if request.method == "POST":

        nombre = request.POST.get("nombre")
        apellido = request.POST.get("apellido")
        dni = request.POST.get("dni")
        correo = request.POST.get("correo")
        telefono = request.POST.get("telefono")
        puesto = request.POST.get("puesto")
        mensaje = request.POST.get("mensaje")

        cv = request.FILES.get("cv")

        ruta_cv = None
        
        print("CORREO RECIBIDO:", repr(correo))
        
        print(
            "VALIDACION:",
            bool(re.match(r"^[^@]+@[^@]+\.[^@]+$", correo))
)
        
        if not nombre.replace(" ", "").isalpha():
            print("Nombre inválido")
            return redirect('postulacion')

        if not apellido.replace(" ", "").isalpha():
            print("Apellido inválido")
            return redirect('postulacion')

        if not dni.isdigit():
            print("DNI inválido")
            return redirect('postulacion')

        if len(dni) < 7 or len(dni) > 8:
            print("DNI inválido")
            return redirect('postulacion')

        if not re.match(r"^[^@]+@[^@]+\.[^@]+$", correo):
            print("Correo inválido")
            messages.error(request, "Ingrese un correo electrónico válido.")
            print("MENSAJE AGREGADO")
            return redirect('postulacion')

        if not telefono.isdigit():
            print("Teléfono inválido")
            return redirect('postulacion')

        if cv:
            fs = FileSystemStorage()
            nombre_archivo = fs.save(cv.name, cv)
            ruta_cv = fs.url(nombre_archivo)
            

        PostulacionLaboral.objects.create(
            nombre=nombre,
            apellido=apellido,
            dni=dni,
            correo=correo,
            telefono=telefono,
            puesto=puesto,
            mensaje=mensaje,
            cv=ruta_cv,
            fecha_postulacion=datetime.now()
        )

        print("Postulación guardada correctamente")
        
        correo = EmailMessage(
            subject=f"Nueva postulación - {nombre} {apellido}",
            body=f"""
        Nueva postulación recibida

        Nombre: {nombre}
        Apellido: {apellido}
        DNI: {dni}
        Correo: {correo}
        Teléfono: {telefono}
        Puesto: {puesto}

        Mensaje:
        {mensaje}
        """,
            from_email='educarparatransformarcolegio@gmail.com',
            to=['educarparatransformarcolegio@gmail.com']
        )
        
        if cv:
            correo.attach(
                cv.name,
                cv.read(),
                cv.content_type
            )
        
        correo.send()
        
        messages.success(
            request,
            "La postulación fue enviada correctamente. Nos pondremos en contacto si tu perfil coincide con una búsqueda."
        )

    return redirect('postulacion')

@never_cache
def enviar_consulta(request):

    if request.method == "POST":

        nombre = request.POST.get("nombre", "").strip()
        correo = request.POST.get("email", "").strip()
        mensaje = request.POST.get("mensaje", "").strip()

        # Nombre
        if not nombre.replace(" ", "").isalpha():
            messages.error(
                request,
                "El nombre solo puede contener letras."
            )
            return redirect('contacto')

        # Correo
        if not re.match(
            r"^[^@]+@[^@]+\.[^@]+$",
            correo
        ):
            messages.error(
                request,
                "Ingrese un correo electrónico válido."
            )
            return redirect('contacto')

        # Mensaje
        if not mensaje:
            messages.error(
                request,
                "Debe escribir una consulta."
            )
            return redirect('contacto')

        email = EmailMessage(
            subject=f"Consulta desde la web - {nombre}",
            body=f"""
Nueva consulta recibida

Nombre: {nombre}
Correo: {correo}

Mensaje:
{mensaje}
""",
            from_email='educarparatransformarcolegio@gmail.com',
            to=['educarparatransformarcolegio@gmail.com']
        )

        try:
            email.send()
        except Exception as e:
            print("ERROR SMTP:", e)
            raise

        email.send()

        messages.success(
            request,
            "La consulta fue enviada correctamente."
        )


    persona = obtener_persona(request)

    if persona:

        if Tutor.objects.filter(id_persona=persona).exists():
            request.session["panel_activo"] = "contacto"
            return redirect('dashboard-padres')

        if Alumno.objects.fifaprlter(id_persona=persona).exists():
            request.session["panel_activo"] = "contacto"
            return redirect('dashboard-alumno')

    return redirect('contacto')


@never_cache
def dashboard_administrativo(request):
    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    administrativo = PersonalAdministrativo.objects.filter(
        id_persona=persona
    ).first()

    instalaciones = Instalacion.objects.all()
    
    reservas = Reserva.objects.select_related(
        'id_instalacion',
        'id_persona_solicitante'
    ).all()
    
    if os.path.exists(OPINIONES_FILE):
        with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
            opiniones = json.load(f)
    else:
        opiniones = []
    
    cuotas = Cuota.objects.select_related(
        'id_tutor__id_persona',
        'id_legajo_alumno__id_persona'
    )
    
    cuotas_pendientes = Cuota.objects.filter(
        estado='Vencida'
    ).count()

    solicitudes = SolicitudInscripcion.objects.all().order_by('-fecha_solicitud')

    inscripciones_pendientes = SolicitudInscripcion.objects.filter(
        estado="pendiente"
    ).count()
    

    return render(request, 'core/dashboard-administrativo.html', {
        'persona': persona,
        'administrativo': administrativo,
        'instalaciones': instalaciones,
        'reservas': reservas,
        'opiniones': opiniones,
        'cuotas': cuotas,
        'cuotas_pendientes': cuotas_pendientes,
        'solicitudes': solicitudes,
        'inscripciones_pendientes': inscripciones_pendientes,
    })
    
@never_cache
def aprobar_cuota(request, id_cuota):

    cuota = Cuota.objects.get(
        id_cuota=id_cuota
    )

    cuota.estado = "Pagada"
    cuota.pagada = 1

    cuota.save()

    return redirect('dashboard-administrativo')    

@never_cache
def aprobar_inscripcion(request, id_solicitud):

    solicitud = SolicitudInscripcion.objects.get(
        id_solicitud=id_solicitud
    )

    persona_alumno = Persona.objects.create(
        dni=solicitud.dni_alumno,
        nombre=solicitud.nombre_alumno,
        apellido=solicitud.apellido_alumno,
        fecha_nacimiento=solicitud.fecha_nacimiento,
        direccion=solicitud.direccion,
        telefono=solicitud.telefono_alumno or solicitud.telefono,
        email=solicitud.email_alumno or solicitud.email
    )

    persona_tutor = Persona.objects.create(
        dni=solicitud.dni_tutor,
        nombre=solicitud.nombre_tutor,
        apellido=solicitud.apellido_tutor,
        fecha_nacimiento=date(2000, 1, 1),
        telefono=solicitud.telefono,
        email=solicitud.email,
        direccion=solicitud.direccion_tutor,
    )

    tutor = Tutor.objects.create(
        id_persona=persona_tutor,
        telefono_contacto=solicitud.telefono,
        email_contacto=solicitud.email
    )

    curso = Curso.objects.filter(
        nivel__iexact=solicitud.nivel,
        turno__iexact=solicitud.turno
    ).first()

    if not curso:
        solicitud.estado = 'Error'
        solicitud.save()

        return redirect('dashboard-administrativo')

    alumno = Alumno.objects.create(
        id_persona=persona_alumno,
        fecha_ingreso=date.today(),
        id_curso=curso
    )

    TutorTutoraAlumno.objects.create(
        id_tutor=tutor,
        id_alumno=alumno,
        tipo_parentesco=solicitud.parentesco,
    )

    Inscripcion.objects.create(
        fecha_inscripcion=date.today(),
        estado='Activa',
        id_curso=curso,
        legajo_alumno=alumno
    )

    solicitud.estado = 'Aprobada'
    solicitud.save()

    return redirect('dashboard-administrativo')

@never_cache
def crear_reserva(request):
    print(request.POST)

    if request.method == "POST":

        id_instalacion = request.POST.get("espacio")
        fecha = request.POST.get("fecha")
        responsable = request.POST.get("responsable")
        
        horario = request.POST.get("horario", "").strip()

        if "-" not in horario:
            messages.error(request, "Debe escribir un horario válido.")
            return redirect(reverse('dashboard-administrativo') + '#reservas')

        hora_inicio, hora_fin = horario.split("-", 1)

        
        try:
            instalacion = Instalacion.objects.get(pk=id_instalacion)
        except Instalacion.DoesNotExist:
            messages.error(request, "Debe seleccionar un espacio válido.")
            return redirect(reverse('dashboard-administrativo') + '#reservas')

        partes = responsable.strip().split()

        if len(partes) < 2:
            messages.error(
                request,
                "Debe ingresar el nombre y apellido del solicitante. Ejemplo: Juan Ramírez."
            )
            return redirect(reverse('dashboard-administrativo') + '#reservas')

        nombre = partes[0]
        apellido = partes[1]

        persona = Persona.objects.filter(
            nombre__iexact=nombre,
            apellido__iexact=apellido
        ).first()

        if not persona:
            messages.error(
                request,
                "No se encontró una persona con ese nombre y apellido."
            )
            return redirect(reverse('dashboard-administrativo') + '#reservas')

        administrativo = PersonalAdministrativo.objects.first()
        
        try:
            hora_inicio = datetime.strptime(hora_inicio.strip(), "%H:%M").time()
            hora_fin = datetime.strptime(hora_fin.strip(), "%H:%M").time()
        except ValueError:
            messages.error(request, "El horario ingresado no es válido.")
            return redirect(reverse('dashboard-administrativo') + '#reservas')
        
        fecha = request.POST.get("fecha")
        

        try:
            fecha = datetime.strptime(fecha, "%Y-%m-%d").date()
        except (TypeError, ValueError):
            messages.error(request, "La fecha ingresada no es válida.")
            return redirect(reverse('dashboard-administrativo') + '#reservas')

        if fecha < date.today():
            messages.error(request, "No se pueden registrar reservas para días anteriores.")
            return redirect(reverse('dashboard-administrativo') + '#reservas')
        
        if Reserva.objects.filter(
            id_instalacion=instalacion,
            fecha=fecha,
            hora_inicio=hora_inicio,
            hora_fin=hora_fin
        ).exists():
            messages.error(
                request,
                "Ya existe una reserva para ese espacio, fecha y horario."
            )
            return redirect(reverse('dashboard-administrativo') + '#reservas')


        Reserva.objects.create(
            nombre=f"Reserva {instalacion.nombre}",
            fecha=fecha,
            hora_inicio=hora_inicio,
            hora_fin=hora_fin,
            legajo_personal_evaluador=administrativo,
            id_persona_solicitante=persona,
            id_instalacion=instalacion
        )

        messages.success(request, "Reserva registrada correctamente.")
        return redirect(reverse('dashboard-administrativo') + '#reservas')

@never_cache
def eliminar_opinion(request, indice):

    if request.method == "POST":

        if os.path.exists(OPINIONES_FILE):

            with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
                opiniones = json.load(f)

            if 0 <= indice < len(opiniones):
                opiniones.pop(indice)

            with open(OPINIONES_FILE, 'w', encoding='utf-8') as f:
                json.dump(opiniones, f, ensure_ascii=False, indent=2)

    return redirect('dashboard-administrativo')

@never_cache
def crear_usuario(request):

    if request.method == "POST":

        dni = request.POST.get("dni")
        nombre_usuario = request.POST.get("nombre_usuario")
        contrasenia = request.POST.get("contrasenia")

        persona = Persona.objects.filter(
            dni=dni
        ).first()

        if not persona:
            print("No existe una persona con ese DNI")
            return redirect('dashboard-administrativo')

        if persona.id_usuario:
            print("La persona ya tiene usuario")
            return redirect('dashboard-administrativo')

        if Usuario.objects.filter(
            nombre_usuario=nombre_usuario
        ).exists():
            print("El nombre de usuario ya existe")
            return redirect('dashboard-administrativo')
        
        correo = request.POST.get("correo")
        
        if Usuario.objects.filter(correo=correo).exists():
            print("Ese correo ya existe")
            return redirect('dashboard-administrativo')

        usuario = Usuario.objects.create(
            nombre_usuario=nombre_usuario,
            contrasenia=contrasenia,
            correo=correo
        )

        persona.id_usuario = usuario
        persona.save()

        print("Usuario creado correctamente")

    return redirect('dashboard-administrativo')

@never_cache
def dashboard_padres(request):

    persona = obtener_persona(request)

    if not persona:
        return redirect('login')

    tutor = Tutor.objects.filter(
        id_persona=persona
    ).first()

    hijos = []

    presentes = 0
    ausencias = 0
    tardanzas = 0

    suma_promedios = 0
    cantidad_promedios = 0

    if tutor:

        relaciones = TutorTutoraAlumno.objects.filter(
            id_tutor=tutor
        ).select_related(
            'id_alumno',
            'id_alumno__id_persona',
            'id_alumno__id_curso'
        )

        for relacion in relaciones:

            alumno = relacion.id_alumno

            promedio = Calificacion.objects.filter(
                legajo_alumno=alumno
            ).aggregate(
                promedio=Avg('nota')
            )['promedio']

            promedio = float(promedio) if promedio else 0

            if promedio:
                suma_promedios += promedio
                cantidad_promedios += 1

            pres = Asistencia.objects.filter(
                legajo_alumno=alumno,
                observacion__icontains='pres'
            ).count()

            aus = Asistencia.objects.filter(
                legajo_alumno=alumno,
                observacion__icontains='aus'
            ).count()

            tar = Asistencia.objects.filter(
                legajo_alumno=alumno,
                observacion__icontains='tard'
            ).count()

            presentes += pres
            ausencias += aus
            tardanzas += tar

            hijos.append({
                'persona': alumno.id_persona,
                'curso': alumno.id_curso,
                'promedio': promedio,
                'presentes': pres,
                'ausencias': aus,
                'tardanzas': tar
            })

    # 📊 promedio general
    promedio_general = round(
        suma_promedios / cantidad_promedios,
        2
    ) if cantidad_promedios else 0

    total_asistencias = presentes + ausencias

    porcentaje_asistencia = round(
        (presentes / total_asistencias) * 100,
        0
    ) if total_asistencias else 0

    # 📢 COMUNICADOS (JSON) SOLO DIRECTIVOS
    COMUNICADOS_FILE = os.path.join(
        settings.BASE_DIR,
        "core",
        "comunicados.json"
    )



    comunicados_filtrados = []
    vistos = set()

    def parse_fecha(c):
        try:
            return datetime.strptime(c.get("fecha", ""), '%d/%m/%Y %H:%M')
        except:
            return datetime.min

    if os.path.exists(COMUNICADOS_FILE):

        try:
            with open(COMUNICADOS_FILE, 'r', encoding='utf-8') as f:
                file_content = f.read().strip()
                comunicados = json.loads(file_content) if file_content else []

            for relacion in relaciones:

                alumno = relacion.id_alumno
                curso_alumno = f"{alumno.id_curso.nivel} {alumno.id_curso.anio}° {alumno.id_curso.comision}"

                for c in comunicados:

                    clave = (
                        c.get('titulo'),
                        c.get('fecha'),
                        c.get('rol')
                    )

                    if clave in vistos:
                        continue

                    # Directivo siempre
                    if c.get('rol') == 'Directivo':
                        comunicados_filtrados.append(c)
                        vistos.add(clave)

                    # Preceptor solo si coincide curso
                    elif (
                        c.get('rol') == 'Preceptor'
                        and c.get('curso', '').strip().lower() == curso_alumno.strip().lower()
                    ):
                        comunicados_filtrados.append(c)
                        vistos.add(clave)

            # 🔥 ORDEN CORRECTO (más nuevos primero)
            comunicados_filtrados.sort(
                key=parse_fecha,
                reverse=True
            )

        except json.JSONDecodeError:
            comunicados_filtrados = []
    panel_activo = request.session.pop("panel_activo", "inicio")
    return render(
        request,
        'core/dashboard-padres.html',
        {
            'persona': persona,
            'hijos': hijos,
            'promedio_general': promedio_general,
            'porcentaje_asistencia': porcentaje_asistencia,
            'presentes': presentes,
            'ausencias': ausencias,
            'tardanzas': tardanzas,
            'noticias': comunicados_filtrados,
            "panel_activo": panel_activo,
        }
    )

@never_cache
def dashboard_preceptor(request):

    persona = obtener_persona(request)

    curso_id = request.POST.get('curso_id') or request.GET.get('curso_id')
    
    if not persona:
        return redirect('login')

    preceptor = Preceptor.objects.filter(
        id_persona=persona
    ).first()

    cursos = Curso.objects.filter(
        legajo_preceptor=preceptor
    )

    curso_seleccionado = None

    if curso_id:
        curso_seleccionado = Curso.objects.filter(
            id_curso=curso_id,
            legajo_preceptor=preceptor
        ).first()

    if curso_seleccionado:
        alumnos = Alumno.objects.filter(
            id_curso=curso_seleccionado
        )

    else:
        alumnos = Alumno.objects.filter(
            id_curso=cursos.first()
        ) if cursos.exists() else []
        
    total_alumnos = 0
    
    if request.method == 'POST':

        fecha_hoy = date.today()

        Asistencia.objects.filter(
            fecha=fecha_hoy,
            legajo_alumno__in=alumnos
        ).delete()

        for alumno in alumnos:

            estado = request.POST.get(
                f'estado_{alumno.legajo}',
                'Presente'
            )

            observacion = request.POST.get(
                f'obs_{alumno.legajo}',
                ''
            )

            Asistencia.objects.create(
                legajo_alumno=alumno,
                fecha=fecha_hoy,
                tipo_asistencia=estado.capitalize(),
                observacion=observacion
            )
        return redirect('dashboard-preceptor') 
        
    for curso in cursos:
        curso.cantidad_alumnos = Alumno.objects.filter(
            id_curso=curso
        ).count()

        total_alumnos += curso.cantidad_alumnos

    hoy = date.today()

    presentes = Asistencia.objects.filter(
        fecha=hoy,
        tipo_asistencia='Presente'
    ).count()

    ausentes = Asistencia.objects.filter(
        fecha=hoy,
        tipo_asistencia='Ausente'
    ).count()

    tardanzas = Asistencia.objects.filter(
        fecha=hoy,
        tipo_asistencia='Tardanza'
    ).count()

    context = {
        'persona': persona,
        'cursos': cursos,
        'total_alumnos': total_alumnos,
        'alumnos': alumnos,
        'cantidad_cursos': cursos.count(),
        'presentes': presentes,
        'ausentes': ausentes,
        'tardanzas': tardanzas,
        'curso_seleccionado': curso_seleccionado,
        'noticias': Noticia.objects.order_by('-fecha_publicacion')[:5],
    }

    return render(
        request,
        'core/dashboard-preceptor.html',
        context
    )

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
        if os.path.exists(OPINIONES_FILE) and os.path.getsize(OPINIONES_FILE) > 0:
            try:
                with open(OPINIONES_FILE, 'r', encoding='utf-8') as f:
                    opiniones = json.load(f)
            except json.JSONDecodeError:
                opiniones = []
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

        messages.success(
            request,
            "Tu opinión fue publicada correctamente. Desplazate hacia abajo para verla en la sección 'Opiniones de visitantes'."
        )

        return redirect('contacto')

def obtener_datos_sesion(request):
    usuario_id = request.session.get('usuario_id')
    if not usuario_id:
        return None, None
    try:
        usuario = Usuario.objects.get(id=usuario_id)
        persona = Persona.objects.filter(id_usuario=usuario).first()
        if not persona:
            return None, None
            
        # Determinar a que dashboard debe redirigir segun su rol
        dashboard_url = 'login'
        if PersonalAdministrativo.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-administrativo'
        elif Docente.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-docente'
        elif Tutor.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-padres'
        elif Preceptor.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-preceptor'
        elif Directivo.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-directivo'
        elif Alumno.objects.filter(id_persona=persona).exists():
            dashboard_url = 'dashboard-alumno'
            
        return persona, dashboard_url
    except Usuario.DoesNotExist:
        return None, None

def logout(request):
    if 'usuario_id' in request.session:
        del request.session['usuario_id']
    return redirect('index')

def crear_comunicado(request):

    if request.method == 'POST':

        titulo = request.POST.get('titulo', '').strip()
        contenido_form = request.POST.get('contenido', '').strip()
        curso_id = request.POST.get('curso')

        persona = obtener_persona(request)

        rol = "Desconocido"

        if Directivo.objects.filter(id_persona=persona.id).exists():
            rol = "Directivo"
        elif Docente.objects.filter(id_persona=persona.id).exists():
            rol = "Docente"
        elif Preceptor.objects.filter(id_persona=persona.id).exists():
            rol = "Preceptor"
        elif PersonalAdministrativo.objects.filter(id_persona=persona.id).exists():
            rol = "Administrativo"

        if not titulo or not contenido_form:
            return redirect('dashboard-directivo')

        if len(contenido_form) > 500:
            return redirect('dashboard-directivo')

        comunicados = []

        if os.path.exists(COMUNICADOS_FILE):
            try:
                with open(COMUNICADOS_FILE, 'r', encoding='utf-8') as f:
                    file_content = f.read().strip()

                    if file_content:
                        comunicados = json.loads(file_content)

            except json.JSONDecodeError:
                comunicados = []

        # 👇 🔥 ACÁ VA LO NUEVO (ANTES DE ARMAR EL OBJETO)

        curso_obj = None

        if rol == "Preceptor" and curso_id:
            curso_obj = Curso.objects.filter(
                id_curso=curso_id,
                legajo_preceptor__id_persona=persona
            ).first()

        # 🔥 ARMADO DEL OBJETO (BASE)
        nuevo_comunicado = {
            'titulo': titulo,
            'contenido': contenido_form,
            'autor': f'{persona.nombre} {persona.apellido}',
            'rol': rol,
            'fecha': datetime.now().strftime('%d/%m/%Y %H:%M')
        }

        # 👇 SOLO SI ES PRECEPTOR
        if rol == "Preceptor" and curso_obj:
            nuevo_comunicado['curso_id'] = curso_obj.id_curso
            nuevo_comunicado['curso'] = f"{curso_obj.nivel} {curso_obj.anio}° {curso_obj.comision}"

        comunicados.append(nuevo_comunicado)

        with open(COMUNICADOS_FILE, 'w', encoding='utf-8') as f:
            json.dump(
                comunicados,
                f,
                ensure_ascii=False,
                indent=2
            )

        if rol == "Preceptor":
            return redirect('dashboard-preceptor')
        elif rol == "Docente":
            return redirect('dashboard-docente')
        elif rol == "Administrativo":
            return redirect('dashboard-administrativo')
        else:
            return redirect('dashboard-directivo')