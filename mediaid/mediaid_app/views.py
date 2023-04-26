from django.shortcuts import render
from .forms import RegistrationForm
from django.views import View
from django.contrib import messages


# Create your views here.
def LandingPage(request):
    return render(request, 'mediaid/LandingPage.html')

def Home(request):
    return render(request, 'mediaid/home.html')

class RegistrationView(View):
    def get(self,request):
        form = RegistrationForm()
        return render(request, 'mediaid/register.html' , {'form':form})
    def post(self, request):
        form = RegistrationForm(request.POST)
        if form.is_valid():
            try:
                form.save()
                messages.success(request, 'Congratulations!! Successfully Registered')
            except:
                messages.success(request, 'Sorry!! Could not be Registered, Try Again')
        return render(request, 'mediaid/register.html' , {'form':form})
