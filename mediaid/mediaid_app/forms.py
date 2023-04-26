from logging import PlaceHolder
from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, SetPasswordForm, PasswordChangeForm, PasswordResetForm, UsernameField
from django.utils.translation import gettext, gettext_lazy as _
from django.contrib.auth.models import User
from django.contrib.auth import get_user_model
from django.contrib.auth import password_validation

class RegistrationForm(UserCreationForm):
        email = forms.CharField(label="Email", required=True, widget=forms.EmailInput(attrs={'class':'form-control','placeholder':'Email', 'style':'opacity:0.8'}))
        username = forms.CharField(label="Username", widget=forms.TextInput(attrs={'class':'form-control','placeholder':'Username', 'style':'opacity:0.8'}))
        password1 = forms.CharField(label="Password", widget=forms.PasswordInput(attrs={'class':'form-control','placeholder':'Password', 'style':'opacity:0.8'}))
        password2 = forms.CharField(label="Confirm Password", widget=forms.PasswordInput(attrs={'class':'form-control','placeholder':'Confirm Password', 'style':'opacity:0.8'}))
        class Meta:
            model = User
            fields = ['username', 'email', 'password1', 'password2']

class LoginForm(AuthenticationForm):
    username = UsernameField(widget=forms.TextInput(attrs={'class':'form-control', 'PlaceHolder':'Username', 'style':'opacity:0.8; color:black'}))
    password = forms.CharField(label=_("Password"), strip=False, widget=forms.PasswordInput(attrs={'autocomplete':'current-password',
    'class':'form-control', 'PlaceHolder':'Password', 'style':'opacity:0.8;'}))