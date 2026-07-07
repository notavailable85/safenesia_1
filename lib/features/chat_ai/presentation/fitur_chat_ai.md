# AI Chat Feature Specification

## Safenesia AI Assistant

Version : 1.0

---

# Overview

Safenesia AI merupakan fitur chatbot berbasis Artificial Intelligence yang terintegrasi dengan Google Gemini.

AI bertugas membantu pengguna mengenai:

* Keselamatan dan Kesehatan Kerja (K3)
* SMK3
* ISO 45001
* Pelatihan
* Sertifikasi
* Regulasi
* APD
* HIRADC
* Job Safety Analysis
* Permit To Work
* Fire Safety
* Emergency Response
* Pertanyaan umum mengenai aplikasi Safenesia

AI bukan sekadar chatbot umum, tetapi menjadi **AI Safety Assistant**.

---

# Tech Stack

## Frontend

* Flutter
* Dart

## Local Database

* SQFlite

Digunakan untuk:

* Offline Cache
* Chat History
* Fast Loading

---

## Cloud

Firebase

Digunakan untuk:

* Firebase Authentication
* Cloud Firestore
* Cloud Functions
* Firebase Storage
* Firebase Cloud Messaging

---

## Artificial Intelligence

Google Gemini API

Model yang direkomendasikan:

* gemini-2.5-flash
* gemini-2.5-pro (opsional untuk kebutuhan analisis yang lebih kompleks)

---

# Architecture

```text
                User

                 │

                 ▼

        Flutter Application

                 │

                 ▼

          Chat Repository

                 │

        ┌────────┴────────┐

        ▼                 ▼

 SQFlite Cache      Firebase Auth

                          │

                          ▼

                 Cloud Functions

                          │

                          ▼

                     Gemini API

                          │

                          ▼

                  AI Response

                          │

         ┌────────────────┴───────────────┐

         ▼                                ▼

 Cloud Firestore                    Flutter UI
```

---

# Why Cloud Functions?

Flutter **tidak boleh** memanggil Gemini API secara langsung.

Alasan:

* API Key akan terlihat pada APK
* Tidak aman
* Sulit mengontrol quota
* Sulit melakukan logging
* Sulit mengganti model AI

Cloud Functions bertugas sebagai gateway.

---

# Folder Structure

```text
lib/

models/
    chat_room_model.dart
    chat_message_model.dart

database/
    chat_database.dart

repositories/
    chat_repository.dart

services/
    ai_service.dart

controllers/
    chat_controller.dart

screens/
    chat/

widgets/
    chat_bubble.dart
    message_input.dart
    typing_indicator.dart
```

---

# Database

## SQFlite

Digunakan untuk:

* Chat History
* Favorite Chat
* Offline Mode
* Draft Message

---

## Firestore

Digunakan untuk:

* Sinkronisasi chat
* Backup chat
* Multi-device
* Analytics

---

# Authentication

Menggunakan Firebase Authentication.

Setiap user memiliki

```text
uid
```

UID digunakan sebagai identitas seluruh percakapan.

---

# Chat Flow

```text
User mengetik pesan

↓

Disimpan ke SQFlite

↓

Langsung tampil pada UI

↓

Repository

↓

Firebase Cloud Function

↓

Gemini API

↓

Gemini menghasilkan jawaban

↓

Disimpan ke Firestore

↓

Disimpan ke SQFlite

↓

UI diperbarui
```

---

# Chat Room

Setiap percakapan memiliki satu Chat Room.

Contoh

```text
Chat 1

Konsultasi SMK3
```

```text
Chat 2

Persiapan Sertifikasi AK3U
```

```text
Chat 3

HIRADC Proyek Gedung
```

---

# Chat Message

Setiap pesan memiliki

* id
* roomId
* sender

```text
user
assistant
system
```

* message
* attachment
* createdAt
* status

---

# Gemini Prompt

Selalu kirim System Prompt sebelum pertanyaan user.

Contoh

```text
You are Safenesia AI.

You are an Occupational Health and Safety Assistant.

Focus only on:

- Indonesian OHS Regulation
- SMK3
- ISO 45001
- Construction Safety
- Fire Safety
- PPE
- Emergency Response
- Mining Safety
- Oil and Gas Safety
- Risk Assessment
- HIRADC
- JSA
- Permit To Work

Always answer in Indonesian unless user requests another language.

If uncertain, clearly state the limitation and encourage verification from official regulations.
```

---

# Conversation Context

Jangan hanya mengirim satu pertanyaan.

Kirim beberapa pesan terakhir.

Contoh

```text
User :
Apa itu HIRADC?

AI :
HIRADC adalah...

User :
Bagaimana cara membuatnya?
```

Dengan context tersebut AI akan memahami percakapan.

---

# AI Features

## Phase 1

* AI Chat
* Chat History
* Copy Message
* Delete Chat
* Share Chat

---

## Phase 2

* Voice to Text
* Text to Speech
* Upload Image
* Upload PDF
* OCR

---

## Phase 3

AI dapat membantu membuat draft:

* HIRADC
* Job Safety Analysis
* Toolbox Meeting
* SOP K3
* Permit To Work
* Risk Assessment
* Emergency Response Plan

---

## Phase 4

Vision AI

AI dapat membaca

* Foto APD
* Foto Area Kerja
* Foto Alat
* Sertifikat
* Dokumen
* SOP

---

# Security

API Key Gemini **tidak boleh** disimpan pada Flutter.

API Key hanya berada di

* Firebase Secret
* Environment Variable Cloud Functions

Flutter hanya mengirim request ke Cloud Functions.

---

# Offline Strategy

Saat internet tidak tersedia

↓

Chat tetap tersimpan pada SQFlite

↓

Ketika internet kembali

↓

Sinkronisasi otomatis ke Firestore

↓

Percakapan tetap konsisten

---

# Development Principles

* Offline First
* Repository Pattern
* Clean Architecture
* Modular
* Future Proof
* Secure API
* Reusable Components

---

# Future Integration

Roadmap pengembangan AI Safenesia:

```text
Flutter

↓

Repository

↓

SQFlite

↓

Firebase Authentication

↓

Cloud Functions

↓

Gemini API

↓

Cloud Firestore
```

Seluruh komponen dirancang agar dapat dikembangkan tanpa perubahan besar ketika Safenesia menambahkan fitur baru seperti AI Vision, analisis dokumen, sinkronisasi multi-device, maupun migrasi ke backend yang lebih kompleks.
