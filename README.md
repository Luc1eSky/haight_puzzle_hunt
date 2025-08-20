# Haight Puzzle Hunt

**Haight Puzzle Hunt** is an immersive puzzle hunt experience set in San Francisco’s iconic Haight-Ashbury neighborhood.  
Players sign up for a time slot, receive story-driven SMS messages from *Cass*, and set out to solve puzzles that blend local history, counterculture, and mystery.

This repository contains the Flutter app and backend functions that power the hunt.

---

## ✨ Features

- 📱 **Flutter App** – cross-platform (iOS/Android/Web) player interface for sign-ups and hints
- 🔔 **Twilio SMS Integration** – players receive messages, verify their booking, and start the hunt by texting back
- 🧩 **Puzzle Progression** – puzzles are tracked in Firestore with states (`booked`, `verified`, `playing`, `finished`, etc.)
- ⚡ **Firebase Cloud Functions** – automatic SMS notifications, verification checks, and game state updates
- ☁️ **Firestore** – stores game bookings, puzzle states, and progress

---

## 🚀 Getting Started

### Prerequisites

- [Flutter](https://docs.flutter.dev/get-started/install) SDK installed
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Twilio account & credentials (`TWILIO_SID`, `TWILIO_AUTH`, `TWILIO_FROM`) stored as Firebase secrets

### Running the App

```bash
# clone the repo
git clone https://github.com/<your-username>/haight_puzzle_hunt.git
cd haight_puzzle_hunt

# get Flutter dependencies
flutter pub get

# run the app (choose ios, android, or web)
flutter run
