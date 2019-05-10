from django.urls import path
from core import views

urlpatterns = [
    path('', views.index, name="index"),
    path('projects/', views.projects, name="projects"),
    path('links/', views.links, name="links"),
    path('guitars/', views.guitars, name="guitars"),
]
