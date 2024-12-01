Donate-Application PROJECT STRUCTURE

lib/
├── auth/                     # to be discussed after later
├── data/
│   ├── …                     # to be discussed after later
├── logic/
│   ├── …                     # to be discussed after later
├── themes/
│   ├── colors.dart           # All colors used in the application
│   ├── …
├── views/
│   ├── screens/
│   │   ├── commons          # Shared screens between user and organization
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   ├── ……
│   │   ├── user/             # User screens
│   │   │   ├── user_profile_details.dart
│   │   │   ├── ……
│   │   ├── organization/     # Organization screens
│   │   │   ├── org_profile_details.dart
│   │   │   ├── ……
│   │   ├── admin/            # Administration screens
│   │   │   ├── manage_users_screen.dart        
│   ├── widgets/
│       ├── shared_widgets/   # Reusable widgets for all platforms
├── main.dart
