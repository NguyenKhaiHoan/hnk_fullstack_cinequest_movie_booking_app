# CineQuest - Movie Ticket Booking App (New version)

## Overview

The previous Firebase-based version of CineQuest (Paused): [CineQuest - Movie Ticket Booking App - Clean Architecture & BLoC](https://github.com/NguyenKhaiHoan/hnk_cinequest_movie)

CineQuest is a **Movie Ticket Booking** application built with **Clean Architecture** principles and utilizes **BLoC** for state management on the frontend. The project features a structured, modular architecture that ensures scalability, testability, and maintainability, making it easy to extend functionality.

The app is developed using **Flutter** for the frontend and **Java Spring Boot** for the backend. The backend handles the core business logic of the app, including authentication with **JWT**, and stores data related to movies, cinemas, and tickets. The frontend interacts with the backend via APIs, which are developed and call **TheMovieDB** API to fetch real movie data. **SQLite**, **Flutter Secure Storage** is used for local data storage on the client-side, and **Get_it** is used for dependency injection.

> [!IMPORTANT]
> This project is for personal study purposes only.

---

## Features

### Implemented Backend Features:

- **Authentication**:

  - User **login** and **registration** with validation.
  - **User verification** via a code sent to the user's email after registration or before a password reset.
  - User can **resend verification code** if the user does not receive the email.
  - Users can recover their account with email-based password reset.

- **Account Management**:

  - **Account Setup**: After registration, users can set up their account with username, name, surname, bio and profile photo.
  - **Account Details**: Fetch detailed user information account.
  - **Account Update**: Users can update their account details information.

- **Favorite Movies**:
  - Each user can create and manage a personalized **list of favorite movies**.
  - The favorites are stored in the backend with user-specific lists, ensuring that each user's favorite movies are distinct.

### Implemented Frontend Features:

- **Auth**: login, signUp, refresh token (using dio interceptor), forgot password (send link reset password via user email), verify user with entering verification code via email, resend verification code, resend link reset password
- **Account**: setup account

### Upcoming Features:

- **Movie Details**: View detailed information about each movie, including genre, runtime, and user ratings.
- **Search Movies**: Search for specific movies from the database.
- **Booking History**: View past ticket bookings.
- **Payment Integration**: Secure booking through integrated payment gateways.
- **Push Notifications**: Notify users about new releases and special offers.
- **Cinema Locations & Seat Selection**: Allow users to choose seats via interactive seat maps.
- **Multi-language Support**: Provide support for multiple languages to enhance user experience.

---

## Demo Videos, Screenshots

The demo is located in the [demo](frontend/assets/demos/) folder

---

## Installation

### Prerequisites:

- Flutter (stable channel): https://docs.flutter.dev/get-started/install
- Java (JDK 21): https://www.oracle.com/java/technologies/downloads/#java21
- IDE: VSCode (Android Studio), Intellij

### Steps:

1. Clone the repository:

```bash
git clone https://github.com/NguyenKhaiHoan/hnk_fullstack_cinequest_movie_booking_app
```

2. Set up environment variables:

Create a .env file in both the backend and frontend directories.

Add the following configurations to the backend/.env file, replacing placeholders with your actual values:

- Database configuration (replace with your MySQL details)

```
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/cinequest
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_password

# JWT secret key
JWT_SECRET_KEY=your_secret_key
JWT_EXPIRATION_TIME=your_expiration_time (hour)
JWT_REFRESHABLE-TIME=your_refreshable_time (hour)

# Mail properties
SUPPORT_EMAIL=your_support_email@example.com
APP_PASSWORD=your_email_app_password
```

- Create a .env file in the frontend directory and add the following configuration:

```
THEMOVIEDB_API_KEY=your_themoviedb_api_key
```

Obtain your API key from https://www.themoviedb.org/.

3. Start the backend server:

Navigate to the backend directory and run:

```bash
mvn clean
mvn spring-boot:run
```

4. Running the App
   Make sure the backend server is running.

In the frontend directory, run:

```bash
flutter clean
flutter pub get
flutter pub run build_runner --delete-conflicting-outputs
flutter run
```

This will launch the CineQuest app on your connected device or emulator.

---

## References

### UI Inspiration and Assets

The UI design and layout of this project were inspired by the work of [Behance - CineQuest](https://www.behance.net/gallery/173303277/CineQuest?tracking_source=search_projects_appreciations|movie+ui+mobile+app&l=510).

- Almost **icons** used in this project were sourced from [Phosphor Icons](https://phosphoricons.com/).
- The **app icon** and **welcome screen background image** were cut from the original design.

### Project

- [Flutter project boilerplate that adheres to Clean Architecture principles](https://github.com/V0-MVP/flutter-bloc-clean-architecture-boilerplate)

### Articles

- [Building Maintainable Flutter Apps with Clean Architecture](https://medium.com/@mvpcatalyst/building-maintainable-flutter-apps-with-clean-architecture-991305ec1744)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
