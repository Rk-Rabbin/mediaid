from django.contrib import admin
from .models import Doctor
# Register your models here.

class DoctorAdmin(admin.ModelAdmin):
    list_display = ('id', 'number', 'gender', 'qualification', 'speciality', 'hospital', 'availability', 'start', 'end')
    list_filter = ('id','number')
    search_fields = ('id', 'number')

admin.site.register(Doctor, DoctorAdmin)
