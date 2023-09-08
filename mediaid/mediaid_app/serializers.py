from rest_framework import serializers
from .models import InsuranceProvider, Doctor, Patient, Prescription, Appointment, User
# from django.contrib.auth.models import User
from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer
from dj_rest_auth.serializers import UserDetailsSerializer
from django.contrib.auth import authenticate, get_user_model

UserModel = User()


class NewUserDetailsSerializer(UserDetailsSerializer):
    class Meta:
        model = User
        fields=["email","id","username"]

class NewRegisterSerializer(RegisterSerializer):
    pass

class NewLoginSerializer(LoginSerializer):
    pass

# class UserSerializer(UserDetailsSerializer):
#     class Meta:
#         model = User
#         fields = ['id', 'username', 'email']

class InsuranceProviderSerializer(serializers.ModelSerializer):
    class Meta:
        model = InsuranceProvider
        fields = ['users', 'name', 'number', 'address', 'policy']

class DoctorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = '__all__'   
    # def create(self, validate_data):
    #     user = validated_data.get('users')
    #     user_obj = User.objects.create(**user)
    #     doc = None
    #     if user_obj:
    #         doc = Doctor.objects.create(users=user_obj, **validate_data)
    #     return doc


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