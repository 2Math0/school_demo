# School Demo API Documentation

## Base URL
```
https://your-supabase-project.supabase.co/rest/v1
```

## Authentication

### Sign Up
```http
POST /auth/v1/signup
```

Request Body:
```json
{
  "email": "user@example.com",
  "password": "password123",
  "user_metadata": {
    "fullName": "John Doe",
    "isInstructor": false,
    "avatar": "https://example.com/avatar.jpg",
    "bio": "Software developer"
  }
}
```

Response:
```json
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "user@example.com",
    "user_metadata": {
      "fullName": "John Doe",
      "isInstructor": false,
      "avatar": "https://example.com/avatar.jpg",
      "bio": "Software developer"
    },
    "created_at": "2024-04-06T12:00:00Z",
    "updated_at": "2024-04-06T12:00:00Z"
  },
  "session": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Sign In
```http
POST /auth/v1/token?grant_type=password
```

Request Body:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "user@example.com",
    "user_metadata": {
      "fullName": "John Doe",
      "isInstructor": false,
      "avatar": "https://example.com/avatar.jpg",
      "bio": "Software developer"
    }
  },
  "session": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Sign Out
```http
POST /auth/v1/logout
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "success": true
}
```

### Forgot Password
```http
POST /auth/v1/recover
```

Request Body:
```json
{
  "email": "user@example.com"
}
```

Response:
```json
{
  "success": true,
  "message": "Password reset email sent"
}
```

## User Profile

### Get User Profile
```http
GET /users/{userId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "email": "user@example.com",
  "user_metadata": {
    "fullName": "John Doe",
    "isInstructor": false,
    "avatar": "https://example.com/avatar.jpg",
    "bio": "Software developer"
  },
  "enrolled_courses": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174001",
      "title": "Introduction to Flutter",
      "thumbnail": "https://example.com/thumbnail.jpg",
      "progress": 25,
      "last_accessed": "2024-04-06T12:00:00Z"
    }
  ],
  "created_at": "2024-04-06T12:00:00Z",
  "updated_at": "2024-04-06T12:00:00Z"
}
```

### Update User Profile
```http
PATCH /users/{userId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Request Body:
```json
{
  "user_metadata": {
    "fullName": "John Doe",
    "bio": "Senior Software Developer",
    "avatar": "https://example.com/new-avatar.jpg"
  }
}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "email": "user@example.com",
  "user_metadata": {
    "fullName": "John Doe",
    "isInstructor": false,
    "avatar": "https://example.com/new-avatar.jpg",
    "bio": "Senior Software Developer"
  },
  "created_at": "2024-04-06T12:00:00Z",
  "updated_at": "2024-04-06T12:00:00Z"
}
```

## Courses

### Get All Courses
```http
GET /courses
```

Headers:
```
Authorization: Bearer {access_token}
```

Query Parameters:
- `select`: Fields to return (default: *)
- `order`: Sort order (e.g., "created_at.desc")
- `limit`: Items per page (default: 10)
- `offset`: Offset for pagination
- `category`: Filter by category
- `level`: Filter by level
- `search`: Search query
- `is_featured`: Filter featured courses (true/false)
- `is_popular`: Filter popular courses (true/false)

Response:
```json
{
  "data": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "title": "Introduction to Flutter",
      "description": "Learn Flutter from scratch",
      "instructor_id": "123e4567-e89b-12d3-a456-426614174001",
      "instructor": {
        "id": "123e4567-e89b-12d3-a456-426614174001",
        "name": "Jane Smith",
        "avatar": "https://example.com/avatar.jpg"
      },
      "category": "Mobile Development",
      "level": "beginner",
      "rating": 4.5,
      "reviews": 100,
      "students": 1000,
      "thumbnail": "https://example.com/thumbnail.jpg",
      "objectives": ["Learn Flutter basics", "Build your first app"],
      "requirements": ["Basic programming knowledge"],
      "is_featured": true,
      "is_popular": true,
      "created_at": "2024-04-06T12:00:00Z",
      "updated_at": "2024-04-06T12:00:00Z"
    }
  ],
  "count": 100
}
```

### Get Course Details
```http
GET /courses/{courseId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "title": "Introduction to Flutter",
  "description": "Learn Flutter from scratch",
  "instructor_id": "123e4567-e89b-12d3-a456-426614174001",
  "instructor": {
    "id": "123e4567-e89b-12d3-a456-426614174001",
    "name": "Jane Smith",
    "avatar": "https://example.com/avatar.jpg",
    "bio": "Experienced Flutter developer",
    "total_students": 5000,
    "total_courses": 10
  },
  "sections": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174002",
      "title": "Getting Started",
      "description": "Introduction to the course",
      "order": 1,
      "lessons": [
        {
          "id": "123e4567-e89b-12d3-a456-426614174003",
          "title": "Introduction",
          "description": "Course overview",
          "content": "Welcome to the course...",
          "video_url": "https://example.com/video.mp4",
          "duration": 15,
          "order": 1,
          "is_preview": true
        }
      ]
    }
  ],
  "category": "Mobile Development",
  "level": "beginner",
  "rating": 4.5,
  "reviews": 100,
  "students": 1000,
  "thumbnail": "https://example.com/thumbnail.jpg",
  "objectives": ["Learn Flutter basics", "Build your first app"],
  "requirements": ["Basic programming knowledge"],
  "is_featured": true,
  "is_popular": true,
  "created_at": "2024-04-06T12:00:00Z",
  "updated_at": "2024-04-06T12:00:00Z"
}
```

### Enroll in Course
```http
POST /enrollments
```

Headers:
```
Authorization: Bearer {access_token}
```

Request Body:
```json
{
  "course_id": "123e4567-e89b-12d3-a456-426614174000"
}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174001",
  "user_id": "123e4567-e89b-12d3-a456-426614174002",
  "course_id": "123e4567-e89b-12d3-a456-426614174000",
  "enrolled_at": "2024-04-06T12:00:00Z"
}
```

## Progress

### Get Course Progress
```http
GET /progress?course_id=eq.{courseId}&user_id=eq.{userId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "course_id": "123e4567-e89b-12d3-a456-426614174001",
  "user_id": "123e4567-e89b-12d3-a456-426614174002",
  "completed_lessons": ["123e4567-e89b-12d3-a456-426614174003"],
  "current_lesson": "123e4567-e89b-12d3-a456-426614174004",
  "progress": 25,
  "last_accessed": "2024-04-06T12:00:00Z",
  "created_at": "2024-04-06T12:00:00Z",
  "updated_at": "2024-04-06T12:00:00Z"
}
```

### Update Progress
```http
PATCH /progress?id=eq.{progressId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Request Body:
```json
{
  "completed_lessons": ["123e4567-e89b-12d3-a456-426614174004"],
  "current_lesson": "123e4567-e89b-12d3-a456-426614174005",
  "progress": 30,
  "last_accessed": "2024-04-06T12:00:00Z"
}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "course_id": "123e4567-e89b-12d3-a456-426614174001",
  "user_id": "123e4567-e89b-12d3-a456-426614174002",
  "completed_lessons": ["123e4567-e89b-12d3-a456-426614174004"],
  "current_lesson": "123e4567-e89b-12d3-a456-426614174005",
  "progress": 30,
  "last_accessed": "2024-04-06T12:00:00Z"
}
```

## Storage

### Upload Course Thumbnail
```http
POST /storage/v1/object/course-thumbnails/{filename}
```

Headers:
```
Authorization: Bearer {access_token}
Content-Type: image/jpeg
```

Response:
```json
{
  "Key": "course-thumbnails/example.jpg",
  "Location": "https://your-supabase-project.supabase.co/storage/v1/object/public/course-thumbnails/example.jpg"
}
```

### Upload Lesson Video
```http
POST /storage/v1/object/lesson-videos/{filename}
```

Headers:
```
Authorization: Bearer {access_token}
Content-Type: video/mp4
```

Response:
```json
{
  "Key": "lesson-videos/example.mp4",
  "Location": "https://your-supabase-project.supabase.co/storage/v1/object/public/lesson-videos/example.mp4"
}
```

## Error Responses

All endpoints may return the following error responses:

```json
{
  "error": {
    "message": "Error message",
    "status": 400
  }
}
```

Common error codes:
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Internal Server Error
