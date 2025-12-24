Poster Wall 📸

Poster Wall is a Flutter application that displays high-quality images fetched from the Pexels API in a beautiful masonry grid layout.
Users can search posters, view them in full screen, mark favorites, and enjoy a smooth animated gallery background.


✨ Features

🖼️ Masonry (staggered) grid image layout

🔍 Search posters in real-time

❤️ Favorite / unfavorite images

📄 Full image preview with details

🔄 Pull-to-refresh & infinite scroll

🎞️ Animated auto-scrolling gallery background

📱 Responsive UI for different screen sizes


🛠️ Tech Stack

Flutter Version: 3.35.7

Dart Version: 3.9.2

State Management: GetX

Architecture: MVVM (Model–View–ViewModel)

API: Pexels Curated & Search API

Image Caching: cached_network_image

UI Layout: flutter_staggered_grid_view


lib/
│
├── controllers/        # ViewModels (GetX Controllers)
│   ├── gallery_controller.dart
│   └── login_controller.dart
│
├── models/             # Data Models
│   └── photo_model.dart
│
├── ui/
│   ├── screens/        # UI Screens
│   └── shared/         # Reusable widgets
│
├── services/           # API & data services
│
└── utilities/          # Constants, styles, helpers

## 📦 Packages Used

- get
- cached_network_image
- flutter_staggered_grid_view
- http

-----


## 👨‍💻 Author


**Vikram Limba**
Flutter Developer
GitHub: https://github.com/vikramLimba