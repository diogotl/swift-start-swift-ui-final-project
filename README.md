# Art Institute of Chicago - SwiftUI App

Built with SwiftUI and following clean architecture principles.

## Project Overview

**API**: [Art Institute of Chicago API](https://api.artic.edu/)  
**Difficulty**: 3/3  
**Base URL**: https://api.artic.edu/  
**Theme**: Digital Art Gallery

## Features

- **Discover Tab**: Explore current and past exhibitions
- **Collection Tab**: Browse paginated artwork collection with search functionality
- **Favorites Tab**: Bookmark and manage favorite artworks
- **Search**: Find artworks by title with Elasticsearch-powered search
- **Artist Details**: Detailed artist information with their artwork collection
- **Artwork Details**: Comprehensive artwork information and description
- **Persistent Storage**: Favorites saved using UserDefaults

## Architecture

### Design Patterns
- **MVVM-C**: Model-View-ViewModel-Coordinator architecture
- **Coordinator Pattern**: Centralized navigation management
- **Factory Pattern**: Dependency injection and view creation
- **Repository Pattern**: Data access abstraction layer

### Key Components

#### DTOs
Clean separation between API models and domain models:
- `ArtworkDTO` → `Artwork`
- `ExhibitionDTO` → `Exhibition` 
- `ArtistDTO` → `Artist`

#### Protocols
- `ArtworkRepositoryProtocol`
- `ExhibitionRepositoryProtocol`
- `ArtistRepositoryProtocol`


### Project Structure
```
├── Core/
│   ├── Components/         # Reusable UI components
│   ├── Constants/          # Design system (Colors, Typography, Spacing)
│   ├── Coordinator/        # Navigation management
│   ├── Extensions/         # String utilities
│   ├── Network/           # APIClient, APIError, Endpoint
│   ├── Persistence/       # FavoritesStore
│   └── Repositories/      # Data access layer
└── Features/
    ├── Models/            # Domain models and DTOs
    └── Scenes/           # Feature-based UI organization
        ├── Home/
        ├── Discover/
        ├── Favorite/
        ├── ArtworkDetail/
        ├── ArtistDetail/
        ├── MainTabView/
        └── Splash/
```

## Design System

Centralized design tokens for consistent UI:
- **Colors**: Neutral palette with accent colors
- **Typography**: Serif headings, clean body text
- **Spacing**: Consistent spacing scale

## Getting Started

1. Clone the repository
2. Open `swift-start-swift-ui-final-project.xcodeproj`
3. Set the `BASE_URL` environment variable to `https://api.artic.edu/api/v1`
4. Build and run.
