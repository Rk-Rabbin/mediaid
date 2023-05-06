from django.db import models
from django.contrib.auth.models import User
# Create your models here.

Gender = (
    ('Male','Male'),
    ('Female','Female'),)

class InsuranceProvider(models.Model):
    users = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=40)
    number = models.CharField(max_length=20)
    policy = models.TextField()



class Doctor(models.Model):
    users = models.OneToOneField(User, on_delete=models.CASCADE)
    gender = models.CharField(choices=Gender, default='choose one', max_length=10)
    number = models.CharField(max_length=20)
    hospital = models.CharField(max_length=50)
    speciality = models.TextField(max_length=100)
    qualification = models.TextField(max_length=100)
    availability = models.CharField(max_length=20)
    start = models.CharField(max_length=10)
    end = models.CharField(max_length=10)


class Patient(models.Model):
    users = models.OneToOneField(User, on_delete=models.CASCADE)
    insurance = models.ForeignKey(InsuranceProvider, on_delete=models.CASCADE)
    number = models.CharField(max_length=20)
    birthdate = models.DateField()
    blood = models.CharField(max_length=10)
    gender = models.CharField(choices=Gender, default='choose one', max_length=10)
    medications = models.TextField()
    disease = models.TextField()
    allergy = models.TextField()



class Prescription(models.Model):
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    disease = models.TextField()
    date = models.DateField()
    hospital = models.CharField(max_length=50)
    upload = models.FileField()




