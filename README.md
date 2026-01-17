# Movies App – Flutter

A modern and responsive Movies browsing application built using **Flutter** and integrated with the **TMDB (The Movie Database) API**.

This app allows users to discover popular movies, search them, and manage their personal **Favourites** and **Watchlist**, while displaying full movie details including ratings and notifications.

---

## Features

- Fetches and displays **popular movies** from the TMDB API
- Supports **real-time search**
- Allows users to add or remove movies to:
  - Favourites
  - Watchlist
- Movie Details Screen includes:
  - Movie Banner
  - Movie Name
  - Overview / Description
  - Release Date
  - Genre
  - Circular User Rating Indicator
  - “Play Now” button with in-app notification
- Handles:
  - Loading State
  - Empty State
  - Error State
- Responsive UI for common phone sizes
- Consistent typography and spacing

---

## Setup Instructions

1. Install **Flutter SDK**  
   https://docs.flutter.dev/get-started/install

2. Install either:
   - **Android Studio**
   - or **VS Code with Flutter Extension**

3. Clone this repository:
   git clone https://github.com/sanjaysamahith/movies_app_flutter.git
   cd movies_app_flutter

4. Get Flutter packages:
   flutter pub get
   
5. Run the application: 
   flutter run
   
   ---

## Dependencies Used

| Package | Purpose |
|--------|--------|
| http | Fetch movie data from TMDB |
| provider | Manage favourites & watchlist state |
| flutter_local_notifications | Show Play Now notifications |

---

## Assumptions

- A valid **TMDB API key** is configured inside `tmdb_service.dart`
- Internet connection is required to fetch movies
- Designed primarily for Android & iOS mobile devices

---

## Screens Included

- Movies Listing Screen
- Search Screen
- Movie Details Screen
- Favourites Screen
- Watchlist Screen

---

## Author

**Sanjay Samahith**
