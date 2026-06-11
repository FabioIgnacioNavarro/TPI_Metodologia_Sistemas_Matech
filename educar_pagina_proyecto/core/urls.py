from django.urls import path
from . import views

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
]
