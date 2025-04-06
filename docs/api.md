# School Demo API Documentation

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
  "fullName": "John Doe",
  "isInstructor": false
}
```

Response:

```json
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "user@example.com",
    "fullName": "John Doe",
    "isInstructor": false,
    "createdAt": "2024-04-06T12:00:00Z",
    "updatedAt": "2024-04-06T12:00:00Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
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
    "fullName": "John Doe",
    "isInstructor": false,
    "createdAt": "2024-04-06T12:00:00Z",
    "updatedAt": "2024-04-06T12:00:00Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Sign Out

```http
POST /auth/signout
```

Response:

```json
{
  "success": true,
  "message": "Successfully signed out"
}
```

## Courses

### Get All Courses

```http
GET /courses
```

Query Parameters:

- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10)
- `category`: Filter by category
- `level`: Filter by level (beginner, intermediate, advanced)
- `search`: Search query

Response:

```json
{
  "courses": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "title": "Introduction to Flutter",
      "description": "Learn Flutter from scratch",
      "instructor": {
        "id": "123e4567-e89b-12d3-a456-426614174001",
        "fullName": "Jane Smith",
        "avatar": "https://example.com/avatar.jpg"
      },
      "thumbnail": "https://example.com/thumbnail.jpg",
      "category": "Mobile Development",
      "level": "beginner",
      "duration": 120,
      "rating": 4.5,
      "totalStudents": 1000,
      "price": 49.99,
      "createdAt": "2024-04-06T12:00:00Z",
      "updatedAt": "2024-04-06T12:00:00Z"
    }
  ],
  "total": 100,
  "page": 1,
  "limit": 10
}
```

### Get Course Details

```http
GET /courses/{courseId}
```

Response:

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "title": "Introduction to Flutter",
  "description": "Learn Flutter from scratch",
  "instructor": {
    "id": "123e4567-e89b-12d3-a456-426614174001",
    "fullName": "Jane Smith",
    "avatar": "https://example.com/avatar.jpg",
    "bio": "Experienced Flutter developer",
    "totalStudents": 5000,
    "totalCourses": 10
  },
  "sections": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174002",
      "title": "Getting Started",
      "lessons": [
        {
          "id": "123e4567-e89b-12d3-a456-426614174003",
          "title": "Introduction",
          "type": "video",
          "duration": 15,
          "preview": true
        }
      ]
    }
  ],
  "requirements": [
    "Basic programming knowledge",
    "Dart programming language"
  ],
  "whatYouWillLearn": [
    "Flutter basics",
    "Widgets and layouts",
    "State management"
  ],
  "thumbnail": "https://example.com/thumbnail.jpg",
  "category": "Mobile Development",
  "level": "beginner",
  "duration": 120,
  "rating": 4.5,
  "totalStudents": 1000,
  "price": 49.99,
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

## Progress

### Get Course Progress

```http
GET /progress/{courseId}
```

Response:

```json
{
  "courseId": "123e4567-e89b-12d3-a456-426614174000",
  "userId": "123e4567-e89b-12d3-a456-426614174001",
  "completedLessons": [
    "123e4567-e89b-12d3-a456-426614174003"
  ],
  "currentLesson": "123e4567-e89b-12d3-a456-426614174004",
  "progress": 25,
  "lastAccessed": "2024-04-06T12:00:00Z",
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

### Update Progress

```http
PUT /progress/{courseId}
```

Request Body:

```json
{
  "lessonId": "123e4567-e89b-12d3-a456-426614174004",
  "completed": true
}
```

Response:

```json
{
  "success": true,
  "message": "Progress updated successfully"
}
```

## Chat

### Get Messages

```http
GET /chat/messages
```

Query Parameters:

- `userId`: User ID to chat with
- `page`: Page number (default: 1)
- `limit`: Messages per page (default: 20)

Response:

```json
{
  "messages": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174005",
      "senderId": "123e4567-e89b-12d3-a456-426614174001",
      "receiverId": "123e4567-e89b-12d3-a456-426614174002",
      "content": "Hello!",
      "type": "text",
      "read": true,
      "createdAt": "2024-04-06T12:00:00Z"
    }
  ],
  "total": 100,
  "page": 1,
  "limit": 20
}
```

### Send Message

```http
POST /chat/messages
```

Request Body:

```json
{
  "receiverId": "123e4567-e89b-12d3-a456-426614174002",
  "content": "Hello!",
  "type": "text"
}
```

Response:

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174005",
  "senderId": "123e4567-e89b-12d3-a456-426614174001",
  "receiverId": "123e4567-e89b-12d3-a456-426614174002",
  "content": "Hello!",
  "type": "text",
  "read": false,
  "createdAt": "2024-04-06T12:00:00Z"
}
```

## Notifications

### Get Notifications

```http
GET /notifications
```

Query Parameters:

- `page`: Page number (default: 1)
- `limit`: Notifications per page (default: 20)
- `read`: Filter by read status (true/false)

Response:

```json
{
  "notifications": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174006",
      "userId": "123e4567-e89b-12d3-a456-426614174001",
      "type": "course_update",
      "title": "New Lesson Available",
      "message": "A new lesson has been added to your course",
      "data": {
        "courseId": "123e4567-e89b-12d3-a456-426614174000",
        "lessonId": "123e4567-e89b-12d3-a456-426614174004"
      },
      "read": false,
      "createdAt": "2024-04-06T12:00:00Z"
    }
  ],
  "total": 50,
  "page": 1,
  "limit": 20
}
```

### Mark Notification as Read

```http
PUT /notifications/{notificationId}/read
```

Response:

```json
{
  "success": true,
  "message": "Notification marked as read"
}
```

## User Profile

### Get User Profile

```http
GET /users/{userId}
```

Response:

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174001",
  "email": "user@example.com",
  "fullName": "John Doe",
  "avatar": "https://example.com/avatar.jpg",
  "bio": "Software developer",
  "isInstructor": false,
  "enrolledCourses": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
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
PUT /users/{userId}
```

Request Body:

```json
{
  "fullName": "John Doe",
  "bio": "Software developer",
  "avatar": "https://example.com/new-avatar.jpg"
}
```

Response:

```json
{
  "id": "123e4567-e89b-12d3-a456-426614174001",
  "email": "user@example.com",
  "fullName": "John Doe",
  "avatar": "https://example.com/new-avatar.jpg",
  "bio": "Software developer",
  "isInstructor": false,
  "createdAt": "2024-04-06T12:00:00Z",
  "updatedAt": "2024-04-06T12:00:00Z"
}
```

## Error Responses

All endpoints may return the following error responses:

### 400 Bad Request

```json
{
  "error": "Bad Request",
  "message": "Invalid request parameters",
  "details": {
    "field": "email",
    "message": "Invalid email format"
  }
}
```

### 401 Unauthorized

```json
{
  "error": "Unauthorized",
  "message": "Authentication required"
}
```

### 403 Forbidden

```json
{
  "error": "Forbidden",
  "message": "You don't have permission to access this resource"
}
```

### 404 Not Found

```json
{
  "error": "Not Found",
  "message": "Resource not found"
}
```

### 500 Internal Server Error

```json
{
  "error": "Internal Server Error",
  "message": "Something went wrong"
}
```
