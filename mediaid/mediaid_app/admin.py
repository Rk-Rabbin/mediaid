from django.contrib import admin
from .models import Doctor, Patient, InsuranceProvider, Prescription
# Register your models here.

class DoctorAdmin(admin.ModelAdmin):
    list_display = ('id','name', 'number', 'gender', 'qualification', 'speciality', 'hospital', 'availability', 'start', 'end', 'profilepic')
    list_filter = ('id','number')
    search_fields = ('id','name', 'number')

class PatientAdmin(admin.ModelAdmin):
    list_display = ('id','name', 'insurance', 'number', 'gender', 'blood', 'birthdate', 'medications', 'disease', 'allergy', 'profilepic')
    list_filter = ('id','number')
    search_fields = ('id','name', 'number')

class InsuranceProviderAdmin(admin.ModelAdmin):
    list_display = ('id','name',  'number', 'address', 'policy')
    list_filter = ('id','number')
    search_fields = ('id','name', 'number')

class PrescriptionAdmin(admin.ModelAdmin):
    list_display = ('id','users', 'doctor', 'patient', 'disease', 'date', 'hospital', 'upload', 'presctext')
    list_filter = ('id','users', 'doctor', 'patient')
    search_fields = ('id','users', 'doctor', 'patient')    

admin.site.register(Doctor, DoctorAdmin)
admin.site.register(Patient,PatientAdmin)
admin.site.register(InsuranceProvider, InsuranceProviderAdmin)
admin.site.register(Prescription,PrescriptionAdmin)
