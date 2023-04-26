from django.urls import path, include
from . import views
from .forms import LoginForm
from django.conf import settings
from django.contrib.auth import views as auth_views
from django.conf.urls.static import static

urlpatterns = [
    path('', views.LandingPage , name='LandingPage'),
    path('home/', views.Home , name='home'),
    path('registration/',views.RegistrationView.as_view(), name='registration'),
    path('accounts/login/', auth_views.LoginView.as_view(template_name='mediaid/login.html', authentication_form=LoginForm), name='login'),
]