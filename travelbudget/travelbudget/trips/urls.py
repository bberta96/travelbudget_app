from django.contrib import admin
from django.urls import path, include
from django.contrib.auth import views as auth_views

from . import views

# URL dispatcher
urlpatterns = [
    path("<int:id>", views.index, name="index"),
    path("searchtrip", views.searchtrip, name="searchtrip"),
    path("register", views.register, name="register"),
    path("account/login", views.user_login, name="login"),
    path("account/logout", views.user_logout, name="logout"),
]