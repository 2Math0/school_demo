# School Demo API Documentation

## Base URL
```
/api/v1
```

## Authentication

### Sign Up
```http
POST /auth/signup
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
POST /auth/signin
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
POST /auth/signout
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

### Reset Password
```http
POST /auth/reset-password
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
  "fullName": "John Doe",
  "avatar": "https://example.com/avatar.jpg",
  "bio": "Software developer",
  "isInstructor": false,
  "enrolledCourses": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174001",
      "title": "Introduction to Flutter",
      "progress": 25,
      "lastAccessed": "2024-04-06T12:00:00Z"
    }
  ],
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
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
  "fullName": "John Doe",
  "bio": "Senior Software Developer",
  "avatar": "https://example.com/new-avatar.jpg"
}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "email": "user@example.com",
  "fullName": "John Doe",
  "avatar": "https://example.com/new-avatar.jpg",
  "bio": "Senior Software Developer",
  "isInstructor": false,
  "enrolledCourses": [...],
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
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
- `category`: Filter by category
- `level`: Filter by level
- `search`: Search query
- `is_featured`: Filter featured courses (true/false)
- `is_popular`: Filter popular courses (true/false)
- `limit`: Items per page (default: 10)
- `offset`: Offset for pagination

Response:
```json
{
  "data": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "title": "Introduction to Flutter",
      "description": "Learn Flutter from scratch",
      "instructorId": "123e4567-e89b-12d3-a456-426614174001",
      "instructorName": "Jane Smith",
      "instructorAvatar": "https://example.com/avatar.jpg",
      "category": "Mobile Development",
      "level": "beginner",
      "rating": 4.5,
      "reviews": 100,
      "students": 1000,
      "thumbnail": "https://example.com/thumbnail.jpg",
      "objectives": ["Learn Flutter basics", "Build your first app"],
      "requirements": ["Basic programming knowledge"],
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
              "videoUrl": "https://example.com/video.mp4",
              "duration": 15,
              "order": 1,
              "isPreview": true
            }
          ]
        }
      ],
      "createdAt": "2024-04-06T12:00:00Z",
      "updatedAt": "2024-04-06T12:00:00Z"
    }
  ],
  "pagination": {
    "total": 100,
    "page": 1,
    "limit": 10,
    "pages": 10,
    "has_next": true,
    "has_prev": false
  }
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
  "instructorId": "123e4567-e89b-12d3-a456-426614174001",
  "instructorName": "Jane Smith",
  "instructorAvatar": "https://example.com/avatar.jpg",
  "category": "Mobile Development",
  "level": "beginner",
  "rating": 4.5,
  "reviews": 100,
  "students": 1000,
  "thumbnail": "https://example.com/thumbnail.jpg",
  "objectives": ["Learn Flutter basics", "Build your first app"],
  "requirements": ["Basic programming knowledge"],
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
          "videoUrl": "https://example.com/video.mp4",
          "duration": 15,
          "order": 1,
          "isPreview": true
        }
      ]
    }
  ],
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

### Enroll in Course
```http
POST /courses/{courseId}/enroll
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "success": true,
  "message": "Successfully enrolled in course"
}
```

## Progress

### Get Course Progress
```http
GET /progress?course_id=eq.{courseId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "courseId": "123e4567-e89b-12d3-a456-426614174001",
  "userId": "123e4567-e89b-12d3-a456-426614174002",
  "completedLessons": ["123e4567-e89b-12d3-a456-426614174003"],
  "currentLesson": "123e4567-e89b-12d3-a456-426614174004",
  "progress": 25,
  "lastAccessed": "2024-04-06T12:00:00Z",
  "allLessons": ["123e4567-e89b-12d3-a456-426614174003", "123e4567-e89b-12d3-a456-426614174004"],
  "totalLessons": 2,
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

### Update Progress
```http
PATCH /progress/{progressId}
```

Headers:
```
Authorization: Bearer {access_token}
```

Request Body:
```json
{
  "completedLessons": ["123e4567-e89b-12d3-a456-426614174004"],
  "currentLesson": "123e4567-e89b-12d3-a456-426614174005",
  "progress": 30,
  "lastAccessed": "2024-04-06T12:00:00Z"
}
```

Response:
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "courseId": "123e4567-e89b-12d3-a456-426614174001",
  "userId": "123e4567-e89b-12d3-a456-426614174002",
  "completedLessons": ["123e4567-e89b-12d3-a456-426614174004"],
  "currentLesson": "123e4567-e89b-12d3-a456-426614174005",
  "progress": 30,
  "lastAccessed": "2024-04-06T12:00:00Z",
  "allLessons": ["123e4567-e89b-12d3-a456-426614174003", "123e4567-e89b-12d3-a456-426614174004"],
  "totalLessons": 2,
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

## Storage

### Upload Course Thumbnail
```http
POST /storage/course-thumbnails
```

Headers:
```
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

Request Body:
```
file: [binary data]
```

Response:
```json
{
  "url": "https://your-supabase-project.supabase.co/storage/v1/object/public/course-thumbnails/example.jpg"
}
```

### Upload Lesson Video
```http
POST /storage/lesson-videos
```

Headers:
```
Authorization: Bearer {access_token}
Content-Type: multipart/form-data
```

Request Body:
```
file: [binary data]
```

Response:
```json
{
  "url": "https://your-supabase-project.supabase.co/storage/v1/object/public/lesson-videos/example.mp4"
}
```

## Error Responses

All endpoints may return the following error responses:

```json
{
  "error": {
    "message": "Error message",
    "status": 400,
    "code": "ERROR_CODE",
    "details": {
      "field": "error details for specific field"
    }
  }
}
```

Common error codes:
- 400: Bad Request
  - INVALID_EMAIL: Invalid email format
  - WEAK_PASSWORD: Password does not meet requirements
  - INVALID_USER_DATA: Invalid user metadata
  - INVALID_COURSE_DATA: Invalid course data
- 401: Unauthorized
  - INVALID_CREDENTIALS: Invalid email or password
  - EXPIRED_TOKEN: Access token has expired
  - INVALID_TOKEN: Invalid access token
- 403: Forbidden
  - COURSE_ACCESS_DENIED: User does not have access to the course
  - INSTRUCTOR_ONLY: Action requires instructor privileges
- 404: Not Found
  - USER_NOT_FOUND: User does not exist
  - COURSE_NOT_FOUND: Course does not exist
  - LESSON_NOT_FOUND: Lesson does not exist
- 409: Conflict
  - EMAIL_EXISTS: Email is already registered
  - ALREADY_ENROLLED: User is already enrolled in the course
- 422: Unprocessable Entity
  - INVALID_FILE_TYPE: Invalid file type for upload
  - FILE_TOO_LARGE: File size exceeds limit
- 500: Internal Server Error
  - DATABASE_ERROR: Database operation failed
  - STORAGE_ERROR: File storage operation failed
  - UNKNOWN_ERROR: Unexpected server error

## Pagination

List endpoints (e.g., courses, messages, notifications) support pagination using the following query parameters:

- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10, max: 100)
- `sort_by`: Field to sort by (e.g., "created_at", "title")
- `sort_order`: Sort order ("asc" or "desc", default: "desc")

Response format for paginated endpoints:
```json
{
  "data": [...],
  "pagination": {
    "total": 100,
    "page": 1,
    "limit": 10,
    "pages": 10,
    "has_next": true,
    "has_prev": false
  }
}
```

## Course Filtering

The courses endpoint supports additional query parameters for filtering:

- `instructor_id`: Filter by instructor
- `min_rating`: Minimum course rating (0-5)
- `min_students`: Minimum number of students
- `max_duration`: Maximum course duration in minutes
- `language`: Course language
- `price_range`: Price range (e.g., "free", "paid", "premium")
- `created_after`: Filter courses created after date (ISO 8601)
- `updated_after`: Filter courses updated after date (ISO 8601)

Example:
```
GET /courses?category=Mobile+Development&level=beginner&min_rating=4&is_featured=true&sort_by=rating&sort_order=desc&page=1&limit=10
```
