from django.shortcuts import render

# Create your views here.


def index(request):
    return render(request, 'core/index.html', {})


def projects(request):
    return render(request, 'core/projects.html', {})


def links(request):
    return render(request, 'core/links.html', {})

def guitars(request):
    return render(request, 'core/guitars.html', {})
