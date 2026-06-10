<p align="center">
  <img src="mediaid_flutter/assets/logo.png" alt="MediAid Logo" width="120"/>
</p>

<h1 align="center">MediAid</h1>

<p align="center">
  A full-stack healthcare management platform connecting patients, doctors, and insurance providers.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.10-3776AB?style=flat&logo=python&logoColor=white"/>
  <img src="https://img.shields.io/badge/Django-4.2-092E20?style=flat&logo=django&logoColor=white"/>
  <img src="https://img.shields.io/badge/Flutter-3.0-02569B?style=flat&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/MySQL-Database-4479A1?style=flat&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/OpenAI-API-412991?style=flat&logo=openai&logoColor=white"/>
  <img src="https://img.shields.io/badge/REST-API-FF6C37?style=flat"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=flat"/>
</p>

---

## Overview

MediAid is a healthcare management system built as a CSE 499A final year capstone project. It provides a complete digital healthcare workflow — from appointment booking and prescription management to AI-powered health assistance and online payment — accessible via both a web interface and a Flutter mobile app.

**Three user roles:** Patient · Doctor · Insurance Provider

---

## Key Highlights

- Designed and built a full-stack system from scratch — backend API, web interface, and mobile app
- Integrated **OpenAI API** to power an AI health chatbot for real-time medical queries
- Implemented **OCR** (pytesseract) to automatically extract text from prescription image uploads
- Integrated **SSLCommerz** payment gateway for secure online appointment payments
- Supports **Google OAuth 2.0** alongside standard email/password authentication
- Built RESTful API consumed by both the web and Flutter mobile clients
- Implemented **BLoC** state management pattern in the Flutter app for clean separation of concerns
- Designed and managed a **relational MySQL database** with 7 interconnected models

---

## Screenshots

> UI designed in Figma — design file available in the repository as `MediAid_App_Design(Figma).pdf`

---

## Tech Stack

### Backend
| | Technology | Role |
|---|---|---|
| ![Python](https://img.shields.io/badge/-Python-3776AB?style=flat&logo=python&logoColor=white) | Python 3.10 | Primary backend language |
| ![Django](https://img.shields.io/badge/-Django-092E20?style=flat&logo=django&logoColor=white) | Django 4.2 + DRF 3.14 | Web framework & REST API |
| ![MySQL](https://img.shields.io/badge/-MySQL-4479A1?style=flat&logo=mysql&logoColor=white) | MySQL | Relational database |
| ![OpenAI](https://img.shields.io/badge/-OpenAI-412991?style=flat&logo=openai&logoColor=white) | OpenAI API | AI health chatbot |
| | pytesseract | OCR — prescription text extraction |
| | SSLCommerz | Online payment gateway |
| | django-allauth + dj-rest-auth | Authentication (email + Google OAuth) |
| | python-dotenv | Environment configuration |

### Mobile App
| | Technology | Role |
|---|---|---|
| ![Flutter](https://img.shields.io/badge/-Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Flutter | Cross-platform mobile (iOS & Android) |
| ![Dart](https://img.shields.io/badge/-Dart-0175C2?style=flat&logo=dart&logoColor=white) | Dart | Mobile language |
| | flutter_bloc | BLoC state management |
| | Hive | Local NoSQL storage |
| | SSLCommerz Flutter | In-app payment |
| | Tawk.io | Live chat support |

---

## Features

### Patient
- Register with personal medical profile (blood type, allergies, medications, disease history)
- Search doctors by speciality and availability
- Book appointments with online or on-site payment via SSLCommerz
- Upload prescription images — text extracted automatically using OCR
- View complete medical records and appointment history
- Manage health insurance information
- AI health chatbot (OpenAI-powered) for medical queries

### Doctor
- Professional profile with speciality, qualifications, hospital, and fee structure
- View and manage incoming patient appointment requests
- Issue prescriptions and view patient medical history
- Earnings and commission tracking dashboard

### Insurance Provider
- Register insurance company and policy details
- Link with patient profiles across the platform

### Admin
- Verify and manage all users (doctors, patients, insurance providers)
- Monitor appointments and transaction history

---

## Architecture

```
┌──────────────────────┐           REST API          ┌────────────────────────┐
│   Flutter Mobile App │ ◄─────────────────────────► │    Django Backend       │
│   (iOS & Android)    │                             │    (DRF + MySQL)        │
└──────────────────────┘                             └───────────┬────────────┘
                                                                 │
                                              ┌──────────────────┴─────────────────┐
                                              │          External Services          │
                                              │  ┌─────────────┐ ┌─────────────┐  │
                                              │  │  OpenAI API │ │  SSLCommerz │  │
                                              │  └─────────────┘ └─────────────┘  │
                                              │  ┌─────────────┐ ┌─────────────┐  │
                                              │  │ Google OAuth│ │   Tesseract │  │
                                              │  └─────────────┘ └─────────────┘  │
                                              └────────────────────────────────────┘
```

---

## Database Schema

```
User (Django Auth)
 ├── Doctor          — license, speciality, hospital, availability, fees
 ├── Patient         — blood type, allergies, medications, disease history
 │    └── Prescription — uploaded image + OCR-extracted text
 ├── Appointment     — links Patient ↔ Doctor, tracks payment & status
 ├── InsuranceProvider — policy details
 └── Commission      — doctor earnings tracking
```

---

## Project Structure

```
mediaid/                  # Django backend
├── mediaid/              # Project settings & URL routing
├── mediaid_app/          # Core app (models, views, serializers, forms)
├── templates/            # HTML templates
└── static/               # CSS, JS, assets

mediaid_flutter/          # Flutter mobile app
├── lib/
│   ├── Screens/          # 15+ UI screens
│   ├── pages/            # Auth & registration pages
│   ├── models/           # Data models (Doctor, Patient, Appointment, etc.)
│   ├── services/         # API service layer
│   └── api/              # Authentication API handlers
└── assets/               # Images and icons
```

---

## Getting Started

### Prerequisites
- Python 3.10+, MySQL, Flutter SDK, Tesseract OCR

### Backend

```bash
git clone https://github.com/Rk-Rabbin/mediaid.git
cd mediaid

python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Set up .env with DB credentials, SECRET_KEY, OpenAI API key, SSLCommerz keys
cd mediaid
python manage.py migrate
python manage.py runserver
```

### Flutter App

```bash
cd mediaid_flutter
flutter pub get
flutter run
```

---

## Academic Context

**Institution:** North South University, Bangladesh
**Course:** CSE 499A — Final Year Capstone Project
**Year:** 2023

This project was developed as a final year capstone, demonstrating end-to-end software engineering capability across system design, backend development, REST API design, mobile development, database management, third-party API integration, and UI/UX implementation.

---

<p align="center">Designed with ❤️ for better healthcare access</p>
