# School Demo Project Commands

## Development Commands

### Setup

```bash
# Install dependencies
flutter pub get
```

```bash
# Generate code (runs build_runner)
flutter pub run build_runner build --delete-conflicting-outputs
```

```bash
# Watch for changes and generate code
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running the App

```bash
# Run in debug mode
flutter run -d chrome

# Run in release mode
flutter run -d chrome --release

# Run with specific flavor
flutter run -d chrome --flavor development
```

### Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/auth_repository_test.dart
```

### Code Quality

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix lints
dart fix --apply
```

## Build Commands

### Web Build

```bash
# Build for web
flutter build wasm
```
```bash
# Build for web with specific flavor
flutter build web --flavor production
```

### Deployment

```bash
# Deploy to GitHub Pages
# 1. Create a new branch for deployment
git checkout -b gh-pages

# 2. Build the web app
flutter build web --wasm

# 3. Copy build files to root
cp -r build/web/* .

# 4. Add and commit changes
git add .
git commit -m "Deploy to GitHub Pages"

# 5. Push to GitHub
git push origin gh-pages

# 6. Go to GitHub repository settings and enable GitHub Pages
# 7. Select gh-pages branch as source
```

## Database Commands

### Supabase

```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Initialize Supabase project
supabase init

# Start local Supabase
supabase start

# Stop local Supabase
supabase stop

# Generate types
supabase gen types typescript --local > lib/types/supabase.ts
```

## Git Commands

```bash
# Initialize git repository
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit"

# Add remote repository
git remote add origin <repository-url>

# Push to remote
git push -u origin main

# Create new branch
git checkout -b feature/new-feature

# Switch branch
git checkout main

# Merge branch
git merge feature/new-feature

# Pull latest changes
git pull origin main

# Push changes
git push origin feature/new-feature
```

## Environment Setup

### Required Environment Variables

```bash
# Create .env file
touch .env

# Add Supabase credentials
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Flutter Configuration

```bash
# Create development configuration
flutter create --org com.schooldemo --platforms=web .

# Add web support
flutter config --enable-web
```

## Troubleshooting

```bash
# Clean project
flutter clean

# Get packages
flutter pub get

# Reset Flutter
flutter doctor

# Check Flutter version
flutter --version

# Update Flutter
flutter upgrade

# Check for outdated packages
flutter pub outdated
```

```bash
chmod +x generate_structure.sh
```

```bash
./generate_structure.sh
```
