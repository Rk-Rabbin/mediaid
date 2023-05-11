from django.contrib import admin
from .models import Doctor, Patient, InsuranceProvider
# Register your models here.

class DoctorAdmin(admin.ModelAdmin):
    list_display = ('id','name', 'number', 'gender', 'qualification', 'speciality', 'hospital', 'availability', 'start', 'end', 'profilepic')
    list_filter = ('id','number')
    search_fields = ('id','name', 'number')

admin.site.register(Doctor, DoctorAdmin)
admin.site.register(Patient)
admin.site.register(InsuranceProvider)
