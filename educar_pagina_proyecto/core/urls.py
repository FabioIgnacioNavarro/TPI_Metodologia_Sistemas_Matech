from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.index, name='index'),
    path('bienestar/', views.bienestar, name='bienestar'),
    path('contacto/', views.contacto, name='contacto'),
    path('inscripcion/', views.inscripcion, name='inscripcion'),
    path('login/', views.login, name='login'),
    path('niveles/', views.niveles, name='niveles'),
    path('noticias/', views.noticias, name='noticias'),
    path('crear-noticia/',views.crear_noticia,name='crear-noticia'),
    path('alumno/', views.dashboard_alumno, name='dashboard-alumno'),
    path('docente/', views.dashboard_docente, name='dashboard-docente'),
    path('directivo/', views.dashboard_directivo, name='dashboard-directivo'),
    path('administrativo/', views.dashboard_administrativo, name='dashboard-administrativo'),
    path('padres/', views.dashboard_padres, name='dashboard-padres'),
    path('preceptor/', views.dashboard_preceptor, name='dashboard-preceptor'),
    path('contacto/opinion/', views.guardar_opinion, name='guardar-opinion'),
    #Cerrar sesión
    path('logout/', views.logout, name='logout'),
    path('crear-comunicado/',views.crear_comunicado,name='crear-comunicado'),
    path('crear-reserva/',views.crear_reserva,name='crear-reserva'),
    path('eliminar-opinion/<int:indice>/',views.eliminar_opinion,name='eliminar-opinion'),
    path('crear-usuario/',views.crear_usuario,name='crear-usuario'),
    path('aprobar-cuota/<int:id_cuota>/',views.aprobar_cuota,name='aprobar-cuota'),
    path('aprobar-inscripcion/<int:id_solicitud>/',views.aprobar_inscripcion,name='aprobar-inscripcion'),
    path('postulacion/',views.postulacion,name='postulacion'),
    path('enviar-postulacion/',views.enviar_postulacion,name='enviar-postulacion'),
    path('enviar-consulta/',views.enviar_consulta,name='enviar-consulta'),
]
if settings.DEBUG:
    urlpatterns += static(
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT
    )
