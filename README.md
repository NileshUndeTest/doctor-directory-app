# doctor_directory_app

### Base URL: https://6a5492808547b9f7111c7104.mockapi.io

# Doctor Directory API

REST API for managing doctors in the Doctor Directory application.

## Base URL

```text
https://6a5492808547b9f7111c7104.mockapi.io
```
---

## Endpoints

### 1. Get All Doctors

Returns a list of all doctors.

**Request**

```http
GET api/hackathon/doctor
```

**Example**

```http
GET {baseUR}/api/hackathon/doctor
```

**Response**

```json
[
  {
    "id": "1",
    "fullName": "Dr. Rahul Verma",
    "avatar": "RV",
    "qualification": "MBBS, MD (Cardiology)",
    "department": "Cardiology",
    "age": "45",
    "yearsOfExperience": "15 Years",
    "status": "Active",
    "about": "Experienced cardiologist specializing in interventional cardiology and cardiac diagnostics.",
    "workExperience": "Senior Cardiologist at Apollo Hospital"
  }
]
```

---

### 2. Get Doctor by ID

Returns details of a specific doctor.

**Request**

```http
GET /api/hackathon/doctor{doctorId}
```

**Example**

```http
GET {baseUR}/api/hackathon/doctor/1
```

---

### 3. Create Doctor

Creates a new doctor record.

**Request**

```http
POST {baseUR}/api/hackathon/doctor
Content-Type: application/json
```

**Request Body**

```json
{
  "fullName": "Dr. Rahul Verma",
  "avatar": "RV",
  "qualification": "MBBS, MD (Cardiology)",
  "department": "Cardiology",
  "age": "45",
  "yearsOfExperience": "15 Years",
  "status": "Active",
  "about": "Experienced cardiologist specializing in interventional cardiology and cardiac diagnostics.",
  "workExperience": "Senior Cardiologist at Apollo Hospital"
}
```

**Example Response**

```json
{
  "id": "1",
  "fullName": "Dr. Rahul Verma",
  "avatar": "RV",
  "qualification": "MBBS, MD (Cardiology)",
  "department": "Cardiology",
  "age": "45",
  "yearsOfExperience": "15 Years",
  "status": "Active",
  "about": "Experienced cardiologist specializing in interventional cardiology and cardiac diagnostics.",
  "workExperience": "Senior Cardiologist at Apollo Hospital"
}
```

---

### 4. Delete Doctor

Deletes a doctor by ID.

**Request**

```http
DELETE /api/hackathon/doctor/{doctorId}
```

**Example**

```http
DELETE {baseUR}/api/hackathon/doctor/1
```

**Response**

```json
{}
```

---

## Doctor Model

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique doctor ID |
| fullName | string | Doctor's full name |
| avatar | string | Avatar initials |
| qualification | string | Educational qualifications |
| department | string | Medical department |
| age | string | Doctor's age |
| yearsOfExperience | string | Total years of experience |
| status | string | Current status (e.g. Active) |
| about | string | Doctor biography |
| workExperience | string | Previous work experience |

---

## HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| 200 | Request successful |
| 201 | Resource created successfully |
| 204 | Resource deleted successfully |
| 400 | Bad request |
| 404 | Doctor not found |
| 500 | Internal server error |

---
