from django.shortcuts import render, redirect
from .forms import RegistrationForm
from django.views import View
import pytesseract
from PIL import Image
from django.contrib import messages
from django.views.decorators.cache import cache_control
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from .models import User, Doctor, Patient, Prescription, InsuranceProvider
from .forms import *
import os
from PIL import Image
from django.conf import settings

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


@method_decorator(login_required, name='dispatch')
class DocRegistration(View):
    def get(self,request):
        return render(request, 'mediaid/doctorreg.html')
    def post(self, request):
        if request.method == "POST":
            usr = request.user
            uid = usr.id
            name = request.POST['name']
            number = request.POST['num']
            gender = request.POST['gender']
            hospital = request.POST['hospital']
            qualification = request.POST['qualification']
            speciality = request.POST['speciality']
            availability = request.POST['availability']
            start = request.POST['start']
            end = request.POST['end']
            fees = request.POST['fees']
            profilepic = request.POST['propic']
            try:
                inr = Doctor.objects.get(users_id=uid)
            except Doctor.DoesNotExist:
                inr = None
            if(inr!=None):
                messages.warning(request, 'user id already exists')
                return render(request, 'mediaid/doctorreg.html', {'message':messages})
            else:  
                reg = Doctor(users_id=uid ,name=name, number=number, gender=gender, hospital=hospital, qualification=qualification, 
                         speciality=speciality, availability=availability, start=start, end=end, fees=fees, profilepic=profilepic)
                reg.save()
                messages.success(request, 'Congratulations!! Successfully registered as a doctor')
                return render(request, 'mediaid/doctorreg.html', {'message':messages})


@method_decorator(login_required, name='dispatch')
class InsuranceProviderReg(View):
    def get(self,request):
        form = InsuranceRegForm()
        return render(request, 'mediaid/insurancereg.html' , {'form':form})
    def post(self, request):
        form = InsuranceRegForm(request.POST)
        if form.is_valid():
            usr = request.user
            uid = usr.id
            number = form.cleaned_data['number']
            name = form.cleaned_data['name']
            address = form.cleaned_data['address']
            policy = form.cleaned_data['policy']
            try:
                inr = InsuranceProvider.objects.get(users_id=uid)
            except InsuranceProvider.DoesNotExist:
                inr = None
            if(inr!=None):
                messages.warning(request, 'User id already exists')
                return render(request, 'mediaid/insurancereg.html', {'message':messages})       
            else:         
                reg = InsuranceProvider(users_id=uid, name=name,number=number, address=address, policy=policy)
                reg.save()
                messages.success(request, 'Congratulations!! Successfully Registered')
                return render(request, 'mediaid/insurancereg.html' , {'form':form})
        else:
            messages.warning(request, 'Sorry!! Invalid Form Content')
            return render(request, 'mediaid/insurancereg.html' , {'form':form})
        

@method_decorator(login_required, name='dispatch')
class PatRegistration(View):
    def get(self,request):
        ins = InsuranceProvider.objects.all()
        return render(request, 'mediaid/patientreg.html',{'ins':ins})
    def post(self, request):
        if request.method == "POST":
            usr = request.user
            uid = usr.id
            name = request.POST['name']
            insurance = request.POST['insurance']
            number = request.POST['num']
            gender = request.POST['gender']
            birthdate = request.POST['birthday']
            blood = request.POST['blood']
            medication = request.POST['medication']
            disease = request.POST['disease']
            allergy = request.POST['allergy']
            profilepic = request.POST['propic']
            ins = InsuranceProvider.objects.all()
            if len(insurance)>0:
                insp = InsuranceProvider.objects.filter(id__icontains=insurance)
                if(insp):
                    try:
                        inr = Patient.objects.get(users_id=uid)
                    except Patient.DoesNotExist:
                        inr = None
                    if(inr!=None):
                        messages.warning(request, 'user id already exists')
                        return render(request, 'mediaid/patientreg.html', {'message':messages, 'ins':ins})
                    else:  
                        reg = Patient(users_id=uid ,name=name, number=number, gender=gender, insurance_id=insurance, medications=medication, 
                                disease=disease, birthdate=birthdate, blood=blood, allergy=allergy, profilepic=profilepic)
                        reg.save()
                        messages.success(request, 'Congratulations!! Successfully registered as a patient')
                        return render(request, 'mediaid/patientreg.html', {'message':messages, 'ins':ins})
                else:
                    messages.warning(request, 'Insurance does not company exist')
                    return render(request, 'mediaid/patientreg.html', {'message':messages, 'ins':ins})
            else:
                insurance = -1
                try:
                    inr = Patient.objects.get(users_id=uid)
                except Patient.DoesNotExist:
                    inr = None
                if(inr!=None):
                    messages.warning(request, 'user id already exists')
                    return render(request, 'mediaid/patientreg.html', {'message':messages, 'ins':ins})
                else:  
                    reg = Patient(users_id=uid ,name=name, number=number, gender=gender, insurance=insurance, medications=medication, 
                    disease=disease, birthdate=birthdate, blood=blood, allergy=allergy, profilepic=profilepic)
                    reg.save()
                    messages.success(request, 'Congratulations!! Successfully registered as a patient')
                    return render(request, 'mediaid/patientreg.html', {'message':messages, 'ins':ins})



@method_decorator(login_required, name='dispatch')
class PrescriptionUp(View):
    def get(self,request):
        # form = PrescriptionUpForm()
        ins = Doctor.objects.all()
        return render(request, 'mediaid/prescriptionup.html' , {'ins':ins})
    def post(self, request):
        ins = Doctor.objects.all()
        if request.method == "POST":
            usr = request.user
            uid = usr.id
            doctor = request.POST['doctor']
            disease = request.POST['disease']
            hospital = request.POST['hospital']
            upload = request.POST['upload']
            text = ""
            try:
                inr = Doctor.objects.get(id=doctor)
            except Doctor.DoesNotExist:
                inr = None
            try:
                pat = Patient.objects.get(users_id=uid)
            except Patient.DoesNotExist:
                pat = None
            if(inr==None):
                messages.warning(request, 'Doctor does not exists')
                return render(request, 'mediaid/prescriptionup.html', {'message':messages, 'ins':ins})
            if(pat==None):
                messages.warning(request, 'First open patient id')
                return redirect('patient-registration')       
            if(text==None):
                messages.warning(request, 'Could not convert prescription into text')
                return render(request, 'mediaid/prescriptionup.html', {'message':messages, 'ins':ins, 't':upload})
            else:         
                reg = Prescription(users_id=uid, doctor_id=doctor,patient_id=pat.id, disease=disease, hospital=hospital, upload=upload, presctext=text)
                reg.save()
                p = Prescription.objects.last()
                img_to_txt(upload, p.id)
                messages.success(request, 'Congratulations!! Successfully Uploaded')
                return render(request, 'mediaid/prescriptionup.html' , {'message':messages, 'ins':ins})
            # image = request.POST['upload']
            # path = settings.MEDIA_ROOT
            # path = path,"/",image
            # image = Image.open(path)
            # image_text = pytesseract.image_to_string(image)
            # text = image_text
            # reg = Prescription(users_id=uid, doctor_id=doctor,patient_id=pat.id, disease=disease, hospital=hospital, upload=upload, presctext=text)
            # messages.success(request, 'Congratulations!! Successfully Uploaded')
            # return render(request, 'mediaid/prescriptionup.html' , {'message':messages, 'ins':ins})
        else:
            messages.warning(request, 'Sorry!! Invalid Form Content')
            return render(request, 'mediaid/prescriptionup.html' , {'message':messages, 'ins':ins})


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def search_view(request):
    search = request.GET['search']
    if len(search)>0:
        doc = Doctor.objects.filter(name__icontains=search) | Doctor.objects.filter(id__icontains=search)
        pat = Patient.objects.filter(name__icontains=search) | Patient.objects.filter(id__icontains=search) 
        params = {'doc':doc, 'pat':pat}
        return render(request,'mediaid/doctorslist.html', params)
    else:
        return render(request,'mediaid/doctorslist.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def patientsearch_view(request):
    return render(request, 'mediaid/patientlist.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def docprofile(request):
    usr = request.user
    uid = usr.id
    try:
        doc = Doctor.objects.get(users_id=uid)
    except Doctor.DoesNotExist:
        doc = None
    if(doc!=None):
        return render(request, 'mediaid/docprofile.html',{'doc':doc})
    else:
        return render(request, 'mediaid/docprofile.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def patprofile(request):
    usr = request.user
    uid = usr.id
    try:
        pat = Patient.objects.get(users_id=uid)
    except Patient.DoesNotExist:
        pat = None
    if(pat!=None):
        return render(request, 'mediaid/patprofile.html',{'pat':pat})
    else:
        return render(request, 'mediaid/patprofile.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def updatedoc(request, id):
    if request.method == 'POST':
        try:
            dl = Doctor.objects.get(id=id)
            fm = DoctorUpdateForm(request.POST, instance=dl)
            if fm.is_valid():
                fm.save()
                return redirect('docprofile')
        except:
            messages.warning(request,"sorry, could not update doctor information!!")
            return render(request, 'mediaid/docprofile.html',{'message':messages})
    else:
        dl = Doctor.objects.get(id=id)
        fm = DoctorUpdateForm(instance=dl)
    return render(request, 'mediaid/updatedoc.html', {'form':fm})


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def updatepat(request, id):
    if request.method == 'POST':
        try:
            dl = Patient.objects.get(id=id)
            fm = PatientUpdateForm(request.POST, instance=dl)
            ins = InsuranceProvider.objects.all()
            if fm.is_valid():
                insurance = fm.cleaned_data['insurance']
                # insurance = insurance.id
                insp = InsuranceProvider.objects.filter(id__icontains=insurance)
                if(insp):
                    fm.save()
                    return redirect('patprofile')                     
                else:
                    messages.warning(request,"Enter valid Insurance company id!!")
                    return render(request, 'mediaid/updatepat.html',{'message':messages, 'form':fm, 'ins':ins})
        except:
            messages.warning(request,"sorry, could not update patient information!!")
            return render(request, 'mediaid/patprofile.html',{'message':messages})
    else:
        ins = InsuranceProvider.objects.all()
        dl = Patient.objects.get(id=id)
        fm = PatientUpdateForm(instance=dl)
    return render(request, 'mediaid/updatepat.html', {'form':fm, 'ins':ins})


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def del_patient(request, id):
    if request.method == 'POST':
        try:
            dl = Patient.objects.get(id=id)
            dl.delete()
            messages.success(request,"successfully deleted patient profile!!")
            return render(request, 'mediaid/patprofile.html',{'message':messages})
        except:
            messages.warning(request,"could not delete patient profile!!")
            return render(request, 'mediaid/patprofile.html',{'message':messages, 'pat':dl})
        


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def del_doctor(request, id):
    if request.method == 'POST':
        try:
            dl = Doctor.objects.get(id=id)
            dl.delete()
            messages.success(request,"successfully deleted doctor profile!!")
            return render(request, 'mediaid/docprofile.html',{'message':messages})
        except:
            messages.warning(request,"could not delete doctor profile!!")
            return render(request, 'mediaid/docprofile.html',{'message':messages, 'doc':dl})


def mydoctors(request):
    return render(request, 'mediaid/mydoctors.html')

def mypatients(request):
    return render(request, 'mediaid/mypatients.html')

def healthhistory(request):
    return render(request, 'mediaid/healthhistory.html')

def prescription(request):
    return render(request, 'mediaid/prescription.html')

def doctorsprofile(request):
    usr = request.user
    uid = usr.id
    try:
        doc = Doctor.objects.get(users_id=uid)
    except Doctor.DoesNotExist:
        doc = None
    if(doc!=None):
        return render(request, 'mediaid/doctorsprofile.html',{'doc':doc})
    else:
        return render(request, 'mediaid/doctorsprofile.html')

def patientprofile(request):
    return render(request, 'mediaid/patientprofile.html')

def img_to_txt(img, id):
    image_text = pytesseract.image_to_string(Image.open("media/"+img))
    text = image_text
    try:
        pr = Prescription.objects.get(id=id)
        pr.presctext = text
        pr.save()
    except Prescription.DoesNotExist:
        print("Could Not save")