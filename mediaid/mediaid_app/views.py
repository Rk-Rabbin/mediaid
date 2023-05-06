from django.shortcuts import render
from .forms import RegistrationForm
from django.views import View
from django.contrib import messages
from django.views.decorators.cache import cache_control
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from .models import User, Doctor, Patient, Prescription, InsuranceProvider
from .forms import *

# Create your views here.
def LandingPage(request):
    return render(request, 'mediaid/LandingPage.html')

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def Home(request):
    return render(request, 'mediaid/home.html')

def Services(request):
    return render(request, 'mediaid/services.html')

def contactus(request):
    return render(request, 'mediaid/contactus.html')

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def ProfilePage(request):
    usr = request.user
    uid = usr.id
    i = 1
    try:
        doc = Doctor.objects.get(users_id=uid)
    except Doctor.DoesNotExist:
        i = 0
    
    if(i==0):
        return render(request, 'mediaid/profile.html',{'usr':usr,'active':'btn-info'})
    else:
        return render(request, 'mediaid/profile.html',{'usr':usr, 'doc':doc ,'active':'btn-info'})


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


@method_decorator(login_required, name='dispatch')
class DocRegistration(View):
    def get(self,request):
        return render(request, 'mediaid/doctorreg.html')
    def post(self, request):
        if request.method == "POST":
            usr = request.user
            uid = usr.id
            number = request.POST['num']
            gender = request.POST['gender']
            hospital = request.POST['hospital']
            qualification = request.POST['qualification']
            speciality = request.POST['speciality']
            availability = request.POST['availability']
            start = request.POST['start']
            end = request.POST['end']
            reg = Doctor(users_id=uid ,number=number, gender=gender, hospital=hospital, qualification=qualification, speciality=speciality, availability=availability, start=start, end=end)
            reg.save()
            messages.success(request, 'Congratulations!! Successfully registered as a doctor')
            return render(request, 'mediaid/doctorreg.html', {'message':messages})


@method_decorator(login_required, name='dispatch')
class PatRegistration(View):
    def get(self,request):
        return render(request, 'mediaid/patientreg.html')
    def post(self, request):
        if request.method == "POST":
            usr = request.user
            uid = usr.id
            number = request.POST['num']
            gender = request.POST['gender']
            hospital = request.POST['hospital']
            qualification = request.POST['qualification']
            speciality = request.POST['speciality']
            availability = request.POST['availability']
            start = request.POST['start']
            end = request.POST['end']
            reg = Doctor(users_id=uid ,number=number, gender=gender, hospital=hospital, qualification=qualification, speciality=speciality, availability=availability, start=start, end=end)
            reg.save()
            messages.success(request, 'Congratulations!! Successfully registered as a patient')
            return render(request, 'mediaid/patientreg.html', {'message':messages})



def search_view(request):
    search = request.GET['search']
    if len(search)>0:
        doc = User.objects.filter(username__icontains=search)
        params = {'doc':doc}
        return render(request,'mediaid/doctorslist.html', params)
    else:
        return render(request,'mediaid/doctorslist.html')


def patientsearch_view(request):
    # search = request.GET['search']
    # if len(search)>0:
    #     garages = Doctors.objects.filter(area__icontains=search)
    #     params = {'garages':garages}
    #     return render(request,'mediaid/garagelist.html', params)
    # else:
    #     return render(request,'mediaid/garagelist.html')
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