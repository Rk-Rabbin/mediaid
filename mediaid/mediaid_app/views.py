from django.shortcuts import render
from .forms import RegistrationForm
from django.views import View
from django.contrib import messages


# Create your views here.
def LandingPage(request):
    return render(request, 'mediaid/LandingPage.html')

def Home(request):
    return render(request, 'mediaid/home.html')

def Services(request):
    return render(request, 'mediaid/services.html')

def contactus(request):
    return render(request, 'mediaid/contactus.html')


def ProfilePage(request):
    usr = request.user
    return render(request, 'mediaid/profile.html',{'usr':usr,'active':'btn-info'})

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


def doctorsearch_view(request):
    # search = request.GET['search']
    # if len(search)>0:
    #     garages = Doctors.objects.filter(area__icontains=search)
    #     params = {'garages':garages}
    #     return render(request,'Homepage/garagelist.html', params)
    # else:
    #     return render(request,'Homepage/garagelist.html')
    return render(request, 'mediaid/doctorslist.html')


def patientsearch_view(request):
    # search = request.GET['search']
    # if len(search)>0:
    #     garages = Doctors.objects.filter(area__icontains=search)
    #     params = {'garages':garages}
    #     return render(request,'Homepage/garagelist.html', params)
    # else:
    #     return render(request,'Homepage/garagelist.html')
    return render(request, 'mediaid/patientlist.html')


def mydoctors(request):
    return render(request, 'mediaid/mydoctors.html')

def mypatients(request):
    return render(request, 'mediaid/mypatients.html')

def healthhistory(request):
    return render(request, 'mediaid/healthhistory.html')

def prescription(request):
    return render(request, 'mediaid/prescription.html')

def doctorsprofile(request):
    return render(request, 'mediaid/doctorsprofile.html')

def patientprofile(request):
    return render(request, 'mediaid/patientprofile.html')