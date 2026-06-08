# MediAid — Healthcare Management Platform

MediAid is a full-stack healthcare management system developed as a final year capstone project (CSE 499A). It connects patients, doctors, and insurance providers through a web platform and a cross-platform mobile application.

---

## Project Structure

```
mediaid/             # Django backend (REST API + web interface)
mediaid_flutter/     # Flutter mobile application
requirements.txt     # Python dependencies
```

---

## Features

### Patient
- Register and manage a personal medical profile (blood type, allergies, medications, diseases)
- Search for doctors by speciality and availability
- Book appointments with online or on-site payment
- Upload and manage prescriptions (with automatic OCR text extraction)
- View full medical records and history
- Manage health insurance information
- AI-powered health chatbot for medical queries

### Doctor
- Create and manage a professional profile (speciality, qualification, hospital, fees)
- View and manage incoming patient appointments
- Upload prescriptions for patients
- Track earnings and commission

### Insurance Provider
- Register and manage insurance policy details
- Link with patient profiles

### Admin
- Verify and manage all users (doctors, patients, insurance providers)
- Monitor appointments and transactions

---

## Tech Stack

### Backend
| Technology | Purpose |
|---|---|
| Django 4.2 | Web framework |
| Django REST Framework 3.14 | REST API |
| MySQL | Primary database |
| dj-rest-auth + django-allauth | Authentication (email + Google OAuth) |
| OpenAI API | AI health chatbot |
| pytesseract | OCR for prescription image text extraction |
| SSLCommerz | Online payment gateway |
| Pillow | Image processing |

### Mobile App
| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile framework (iOS & Android) |
| BLoC | State management |
| Hive | Local data storage |
| SSLCommerz Flutter | In-app payment |
| Tawk.io | Live chat support |

---

## System Architecture

```
┌─────────────────┐        REST API        ┌──────────────────────┐
│  Flutter App    │ ◄────────────────────► │   Django Backend     │
│  (iOS/Android)  │                        │   (DRF + MySQL)      │
└─────────────────┘                        └──────────────────────┘
                                                      │
                                           ┌──────────┴──────────┐
                                           │  External Services  │
                                           │  - OpenAI API       │
                                           │  - SSLCommerz       │
                                           │  - Google OAuth     │
                                           │  - Tesseract OCR    │
                                           └─────────────────────┘
```

---

## Database Models

- **User** — Django built-in authentication
- **Doctor** — Professional profile (license, speciality, availability, fees)
- **Patient** — Medical profile (blood type, allergies, medications, disease history)
- **Prescription** — Medical prescriptions with image upload and OCR-extracted text
- **Appointment** — Scheduled appointments with payment tracking
- **InsuranceProvider** — Insurance company details and policy
- **Commission** — Doctor earnings tracking

---

## Getting Started

### Prerequisites
- Python 3.10+
- MySQL
- Flutter SDK
- Tesseract OCR installed on system

### Backend Setup

```bash
# Clone the repository
git clone https://github.com/Rk-Rabbin/mediaid.git
cd mediaid

# Create and activate virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment variables
# Create mediaid/.env with your database credentials, API keys, etc.

# Run migrations
cd mediaid
python manage.py migrate

# Start development server
python manage.py runserver
```

### Flutter App Setup

```bash
cd mediaid_flutter
flutter pub get
flutter run
```

---

## Design

UI/UX designed in Figma. Design file included in repository: `MediAid_App_Design(Figma).pdf`

---

## Academic Context

This project was developed as a CSE 499A final year capstone project, demonstrating end-to-end software engineering skills including:
- System architecture design
- RESTful API development
- Mobile application development
- Database design and management
- Third-party API integration
- UI/UX design implementation
