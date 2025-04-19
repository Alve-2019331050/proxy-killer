# Proxy Killer
An IoT-based biometric system for managing student attendance using a fingerprint sensor, integrated with a mobile app for tracking and administration.

[Watch Demo](https://www.youtube.com/watch?v=pnN3ixacbHo)

## Hardware Components
  - R307 Fingerprint Sensor
  - ESP32 NodeMCU Development Board
  - Breadboard & Jumper Wires
    
The R307 fingerprint sensor is connected to the ESP32 to capture biometric data, which is then transmitted over Wi-Fi for further processing and storage.

## Software Stack
  - **Flutter** – for Android app development
  - **Firebase** – for backend services (authentication, database, etc.)
  - **Git & GitHub** – for version control and collaboration

## Features

1. ### Admin
   - Sign up as Admin
   - Dashboard overview: total students, teachers, and courses
   - Register new teachers and students
   - Create new courses and assign teachers
   - Reassign teachers to specific courses
2. ### Teacher
   - Sign in as Teacher
   - View the dashboard with assigned courses
   - Enroll or remove students from courses
   - Start class and set the attendance time frame
   - View attendance of a course by date
   - Access personal settings
4. ### Student
   - Sign in as Student
   - View the dashboard with enrolled courses
   - Check attendance (per course, with percentage and detailed stats)
   - Access personal settings

  ## App Workflow
  Biometric data is captured via the fingerprint sensor (R307) and processed using the ESP32. The data is sent to Firebase, where it's linked with student accounts. The mobile app, built with Flutter, provides dashboards and tools for each type of user.
