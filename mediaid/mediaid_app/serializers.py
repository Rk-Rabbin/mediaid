from rest_framework import serializers
from .models import InsuranceProvider, Doctor, Patient, Prescription, Appointment, User
# from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password']

class InsuranceProviderSerializer(serializers.ModelSerializer):
    class Meta:
        model = InsuranceProvider
        fields = ['users', 'name', 'number', 'address', 'policy']

class DoctorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = ['users', 'name', 'gender', 'number', 'licensenum', 'hospital', 'speciality', 'qualification', 'availability', 'start', 'end', 'fees', 'profilepic']

class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = ['users', 'insurance', 'name', 'number', 'birthdate', 'blood', 'gender', 'medications', 'disease', 'allergy', 'profilepic']

class PrescriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Prescription
        fields = ['users', 'doctor', 'patient', 'disease', 'date', 'hospital', 'upload', 'presctext']

class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = ['patient', 'doctor', 'doctor_name', 'patient_name', 'email', 'phone', 'disease', 'expected_date', 'expected_time', 'requested_at', 'accepted']