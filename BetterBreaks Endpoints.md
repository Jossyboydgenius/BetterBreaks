# BetterBreaks API Endpoints

## Overview
This document outlines all the backend API endpoints required for the BetterBreaks application, a comprehensive holiday planning and break optimization platform. The endpoints are organized by functionality area and include request/response specifications.

## Base URL
```
https://api.betterbreaks.com/v1
```

## Authentication

### Auth Endpoints

#### 1. User Registration
```http
POST /auth/register
```
**Request Body:**
```json
{
  "fullName": "string (required)",
  "email": "string (required, valid email)",
  "password": "string (required, min 8 chars)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "user": {
    "id": "uuid",
    "fullName": "string",
    "email": "string",
    "createdAt": "datetime"
  },
  "tokens": {
    "accessToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600
  }
}
```

#### 2. User Login
```http
POST /auth/login
```
**Request Body:**
```json
{
  "email": "string (required)",
  "password": "string (required)"
}
```
**Response:**
```json
{
  "success": true,
  "user": {
    "id": "uuid",
    "fullName": "string",
    "email": "string",
    "profileComplete": "boolean",
    "premiumActive": "boolean"
  },
  "tokens": {
    "accessToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600
  }
}
```

#### 3. Forgot Password
```http
POST /auth/forgot-password
```
**Request Body:**
```json
{
  "email": "string (required)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "OTP sent to email",
  "otpExpiresIn": 300
}
```

#### 4. Verify OTP
```http
POST /auth/verify-otp
```
**Request Body:**
```json
{
  "email": "string (required)",
  "otp": "string (required, 6 digits)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "OTP verified successfully",
  "resetToken": "string"
}
```

#### 5. Reset Password
```http
POST /auth/reset-password
```
**Request Body:**
```json
{
  "resetToken": "string (required)",
  "newPassword": "string (required, min 8 chars)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Password reset successfully"
}
```

#### 6. Refresh Token
```http
POST /auth/refresh
```
**Request Body:**
```json
{
  "refreshToken": "string (required)"
}
```
**Response:**
```json
{
  "success": true,
  "tokens": {
    "accessToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600
  }
}
```

#### 7. Logout
```http
POST /auth/logout
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

#### 8. Social Authentication (Google/Facebook/Apple)
```http
POST /auth/social
```
**Request Body:**
```json
{
  "provider": "string (google|facebook|apple)",
  "token": "string (provider token)",
  "email": "string",
  "fullName": "string"
}
```
**Response:** Same as login response

---

## User Profile Management

#### 9. Get User Profile
```http
GET /user/profile
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "user": {
    "id": "uuid",
    "fullName": "string",
    "email": "string",
    "location": "string",
    "profileImage": "string (url)",
    "breakBalance": "number",
    "premiumActive": "boolean",
    "premiumExpiryDate": "datetime",
    "createdAt": "datetime",
    "updatedAt": "datetime"
  }
}
```

#### 10. Update User Profile
```http
PUT /user/profile
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "fullName": "string",
  "email": "string",
  "location": "string",
  "breakBalance": "number"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Profile updated successfully",
  "user": {
    "id": "uuid",
    "fullName": "string",
    "email": "string",
    "location": "string",
    "breakBalance": "number",
    "updatedAt": "datetime"
  }
}
```

#### 11. Upload Profile Image
```http
POST /user/profile/image
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:** `multipart/form-data`
```
image: file (required, max 5MB, jpg/png)
```
**Response:**
```json
{
  "success": true,
  "message": "Profile image uploaded successfully",
  "imageUrl": "string"
}
```

---

## Work Schedule & Setup

#### 12. Create/Update Work Schedule
```http
POST /user/work-schedule
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "workingPattern": "string (Standard pattern|Custom pattern|Shift pattern)",
  "selectedDays": ["string"] (["Mon", "Tues", "Wed"]),
  "shiftPattern": {
    "daysOn": "string",
    "daysOff": "string", 
    "startDate": "string (dd/MM/yyyy)",
    "rotation": "string"
  },
  "blackoutDates": ["datetime"],
  "optimizationGoals": ["string"]
}
```
**Response:**
```json
{
  "success": true,
  "message": "Work schedule saved successfully",
  "schedule": {
    "id": "uuid",
    "workingPattern": "string",
    "selectedDays": ["string"],
    "shiftPattern": "object",
    "blackoutDates": ["datetime"],
    "optimizationGoals": ["string"],
    "updatedAt": "datetime"
  }
}
```

#### 13. Get Work Schedule
```http
GET /user/work-schedule
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "schedule": {
    "id": "uuid",
    "workingPattern": "string",
    "selectedDays": ["string"],
    "shiftPattern": "object",
    "blackoutDates": ["datetime"],
    "optimizationGoals": ["string"],
    "createdAt": "datetime",
    "updatedAt": "datetime"
  }
}
```

#### 14. Complete Initial Setup
```http
POST /user/setup/complete
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "leaveBalance": "number",
  "workSchedule": "object",
  "preferences": {
    "alignWithSchool": "boolean",
    "alignWithPeak": "boolean"
  }
}
```
**Response:**
```json
{
  "success": true,
  "message": "Setup completed successfully",
  "setupComplete": true
}
```

---

## Break Planning & Recommendations

#### 15. Get Break Recommendations
```http
GET /breaks/recommendations
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `limit` (optional): number (default: 10)
- `highImpactOnly` (optional): boolean

**Response:**
```json
{
  "success": true,
  "recommendations": [
    {
      "id": "uuid",
      "dateRange": "string",
      "description": "string",
      "isHighImpact": "boolean",
      "holidays": ["string"],
      "daysOff": "number",
      "totalDays": "number",
      "optimizationScore": "number"
    }
  ]
}
```

#### 16. Create Break Plan
```http
POST /breaks/plan
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "startDate": "datetime",
  "endDate": "datetime",
  "description": "string",
  "type": "string (vacation|sick|personal)",
  "status": "string (planned|pending|approved|rejected)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Break plan created successfully",
  "plan": {
    "id": "uuid",
    "startDate": "datetime",
    "endDate": "datetime",
    "description": "string",
    "type": "string",
    "status": "string",
    "daysCount": "number",
    "createdAt": "datetime"
  }
}
```

#### 17. Get User Break Plans
```http
GET /breaks/plans
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `status` (optional): string (planned|pending|approved|rejected)
- `year` (optional): number
- `limit` (optional): number
- `offset` (optional): number

**Response:**
```json
{
  "success": true,
  "plans": [
    {
      "id": "uuid",
      "startDate": "datetime",
      "endDate": "datetime",
      "description": "string",
      "type": "string",
      "status": "string",
      "daysCount": "number",
      "daysRemaining": "number",
      "createdAt": "datetime",
      "updatedAt": "datetime"
    }
  ],
  "total": "number",
  "hasMore": "boolean"
}
```

#### 18. Update Break Plan
```http
PUT /breaks/plans/{planId}
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "startDate": "datetime",
  "endDate": "datetime",
  "description": "string",
  "status": "string"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Break plan updated successfully",
  "plan": {
    "id": "uuid",
    "startDate": "datetime",
    "endDate": "datetime",
    "description": "string",
    "status": "string",
    "updatedAt": "datetime"
  }
}
```

#### 19. Delete Break Plan
```http
DELETE /breaks/plans/{planId}
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "message": "Break plan deleted successfully"
}
```

---

## Calendar & Holidays

#### 20. Get Public Holidays
```http
GET /calendar/holidays
```
**Query Parameters:**
- `country` (optional): string (default: UK)
- `year` (optional): number (default: current year)

**Response:**
```json
{
  "success": true,
  "holidays": [
    {
      "date": "datetime",
      "name": "string",
      "type": "string",
      "country": "string"
    }
  ]
}
```

#### 21. Get Weather Forecast
```http
GET /calendar/weather
```
**Query Parameters:**
- `location`: string (required)
- `startDate`: datetime (required)
- `endDate`: datetime (required)

**Response:**
```json
{
  "success": true,
  "forecast": [
    {
      "date": "datetime",
      "day": "string",
      "temperature": "string",
      "weatherType": "string (sunny|cloudy|rainy)",
      "description": "string"
    }
  ]
}
```

---

## Analytics & Insights

#### 22. Get Dashboard Analytics
```http
GET /analytics/dashboard
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "analytics": {
    "totalBreakDays": "number",
    "usedBreakDays": "number",
    "remainingBreakDays": "number",
    "optimizationScore": "number",
    "breakScore": "number",
    "streakMonths": "number",
    "lastAnalysisDate": "datetime"
  }
}
```

#### 23. Get Holiday Distribution Data
```http
GET /analytics/holiday-distribution
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `year` (optional): number (default: current year)

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "month": "string",
      "breaksPlanned": "number",
      "weekends": "number",
      "publicHolidays": "number"
    }
  ]
}
```

#### 24. Get Optimization Timeline
```http
GET /analytics/optimization-timeline
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `period` (optional): string (6months|1year) (default: 6months)

**Response:**
```json
{
  "success": true,
  "timeline": [
    {
      "month": "string",
      "optimizationDays": "number",
      "efficiency": "number"
    }
  ]
}
```

#### 25. Get Break Balance Analysis
```http
GET /analytics/break-balance
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "analysis": {
    "totalAllowance": "number",
    "used": "number",
    "planned": "number",
    "available": "number",
    "carryOver": "number",
    "monthlyDistribution": [
      {
        "month": "string",
        "planned": "number",
        "used": "number"
      }
    ]
  }
}
```

---

## Experience & Events

#### 26. Get Events/Experiences
```http
GET /experiences/events
```
**Query Parameters:**
- `category` (optional): string (All|Top picks|Sports|Music|Movies|Health)
- `location` (optional): string
- `startDate` (optional): datetime
- `endDate` (optional): datetime
- `minPrice` (optional): number
- `maxPrice` (optional): number
- `search` (optional): string
- `limit` (optional): number (default: 20)
- `offset` (optional): number (default: 0)

**Response:**
```json
{
  "success": true,
  "events": [
    {
      "id": "uuid",
      "title": "string",
      "description": "string",
      "location": "string",
      "date": "datetime",
      "price": "string",
      "image": "string (url)",
      "category": "string",
      "isTopPick": "boolean",
      "isFullWidth": "boolean"
    }
  ],
  "total": "number",
  "hasMore": "boolean"
}
```

#### 27. Get Event Details
```http
GET /experiences/events/{eventId}
```
**Response:**
```json
{
  "success": true,
  "event": {
    "id": "uuid",
    "title": "string",
    "description": "string",
    "location": "string",
    "date": "datetime",
    "price": "string",
    "image": "string (url)",
    "category": "string",
    "isTopPick": "boolean",
    "additionalImages": ["string"],
    "amenities": ["string"],
    "cancellationPolicy": "string"
  }
}
```

#### 28. Book Event
```http
POST /experiences/events/{eventId}/book
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "quantity": "number",
  "participantName": "string",
  "participantEmail": "string",
  "date": "datetime",
  "specialRequests": "string"
}
```
**Response:**
```json
{
  "success": true,
  "booking": {
    "id": "uuid",
    "eventId": "uuid",
    "quantity": "number",
    "totalPrice": "number",
    "status": "string (confirmed|pending|cancelled)",
    "bookingReference": "string",
    "createdAt": "datetime"
  }
}
```

#### 29. Get User Bookings
```http
GET /experiences/bookings
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `status` (optional): string (confirmed|pending|cancelled)
- `limit` (optional): number
- `offset` (optional): number

**Response:**
```json
{
  "success": true,
  "bookings": [
    {
      "id": "uuid",
      "eventId": "uuid",
      "eventTitle": "string",
      "quantity": "number",
      "totalPrice": "number",
      "status": "string",
      "bookingReference": "string",
      "eventDate": "datetime",
      "createdAt": "datetime"
    }
  ]
}
```

---

## Mood Tracking

#### 30. Submit Mood Check-in
```http
POST /mood/checkin
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "mood": "string (expressionless|grinning|star_eyes|relieved|smiling_with_tear|sad_pensive)",
  "date": "datetime",
  "notes": "string (optional)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Mood recorded successfully",
  "checkin": {
    "id": "uuid",
    "mood": "string",
    "date": "datetime",
    "notes": "string",
    "createdAt": "datetime"
  }
}
```

#### 31. Get Mood History
```http
GET /mood/history
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `startDate` (optional): datetime
- `endDate` (optional): datetime
- `limit` (optional): number (default: 30)

**Response:**
```json
{
  "success": true,
  "history": [
    {
      "id": "uuid",
      "mood": "string",
      "date": "datetime",
      "notes": "string",
      "createdAt": "datetime"
    }
  ],
  "averageMood": "string",
  "moodTrend": "string (improving|declining|stable)"
}
```

---

## Notifications & Settings

#### 32. Get Notification Preferences
```http
GET /user/notification-preferences
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "preferences": {
    "breaksReminder": "boolean",
    "suggestions": "boolean",
    "deadlineAlerts": "boolean",
    "weeklyDigest": "boolean",
    "pushEnabled": "boolean",
    "emailEnabled": "boolean"
  }
}
```

#### 33. Update Notification Preferences
```http
PUT /user/notification-preferences
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "breaksReminder": "boolean",
  "suggestions": "boolean", 
  "deadlineAlerts": "boolean",
  "weeklyDigest": "boolean",
  "pushEnabled": "boolean",
  "emailEnabled": "boolean"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Notification preferences updated successfully"
}
```

#### 34. Get App Settings
```http
GET /user/settings
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "settings": {
    "theme": "string (light|dark|system)",
    "language": "string",
    "timezone": "string",
    "currency": "string"
  }
}
```

#### 35. Update App Settings
```http
PUT /user/settings
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "theme": "string",
  "language": "string",
  "timezone": "string", 
  "currency": "string"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Settings updated successfully"
}
```

---

## Premium Subscription

#### 36. Get Subscription Status
```http
GET /subscription/status
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "subscription": {
    "isActive": "boolean",
    "plan": "string (premium|free)",
    "price": "string",
    "currency": "string",
    "billingCycle": "string (monthly|yearly)",
    "startDate": "datetime",
    "expiryDate": "datetime",
    "autoRenew": "boolean",
    "features": ["string"]
  }
}
```

#### 37. Get Subscription Plans
```http
GET /subscription/plans
```
**Response:**
```json
{
  "success": true,
  "plans": [
    {
      "id": "string",
      "name": "string",
      "price": "number",
      "currency": "string",
      "billingCycle": "string",
      "features": ["string"],
      "isPopular": "boolean"
    }
  ]
}
```

#### 38. Subscribe to Premium
```http
POST /subscription/subscribe
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "planId": "string",
  "paymentMethodId": "string",
  "billingCycle": "string (monthly|yearly)"
}
```
**Response:**
```json
{
  "success": true,
  "subscription": {
    "id": "uuid",
    "plan": "string",
    "status": "string",
    "startDate": "datetime",
    "expiryDate": "datetime"
  },
  "paymentIntent": {
    "clientSecret": "string",
    "status": "string"
  }
}
```

#### 39. Cancel Subscription
```http
POST /subscription/cancel
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "reason": "string (optional)",
  "feedback": "string (optional)"
}
```
**Response:**
```json
{
  "success": true,
  "message": "Subscription cancelled successfully",
  "effectiveDate": "datetime"
}
```

---

## Milestones & Achievements

#### 40. Get User Milestones
```http
GET /milestones
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "milestones": {
    "breakScore": "number",
    "streakMonths": "number",
    "totalBreaksDays": "number",
    "optimizationScore": "number",
    "badges": [
      {
        "id": "string",
        "name": "string",
        "description": "string",
        "icon": "string",
        "earnedDate": "datetime"
      }
    ],
    "achievements": [
      {
        "id": "string",
        "title": "string",
        "description": "string",
        "progress": "number",
        "target": "number",
        "completed": "boolean"
      }
    ]
  }
}
```

---

## Support & Help

#### 41. Submit Support Message
```http
POST /support/message
```
**Headers:** `Authorization: Bearer {token}`
**Request Body:**
```json
{
  "subject": "string",
  "message": "string",
  "category": "string (bug|feature|general|billing)",
  "priority": "string (low|medium|high)"
}
```
**Response:**
```json
{
  "success": true,
  "ticket": {
    "id": "uuid",
    "subject": "string",
    "status": "string (open|in_progress|resolved|closed)",
    "createdAt": "datetime"
  }
}
```

#### 42. Get Support Tickets
```http
GET /support/tickets
```
**Headers:** `Authorization: Bearer {token}`
**Response:**
```json
{
  "success": true,
  "tickets": [
    {
      "id": "uuid",
      "subject": "string",
      "status": "string",
      "category": "string",
      "createdAt": "datetime",
      "lastUpdated": "datetime"
    }
  ]
}
```

---

## Data Export (Premium Feature)

#### 43. Export Analytics Data
```http
GET /export/analytics
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `format`: string (csv|json|pdf)
- `year`: number (optional)
- `includeCharts`: boolean (optional, for PDF)

**Response:**
```json
{
  "success": true,
  "downloadUrl": "string",
  "expiresAt": "datetime"
}
```

#### 44. Export Break Plans
```http
GET /export/break-plans
```
**Headers:** `Authorization: Bearer {token}`
**Query Parameters:**
- `format`: string (csv|json|ics)
- `year`: number (optional)

**Response:**
```json
{
  "success": true,
  "downloadUrl": "string",
  "expiresAt": "datetime"
}
```

---

## Error Responses

All endpoints may return the following error responses:

### 400 Bad Request
```json
{
  "success": false,
  "error": "Bad Request",
  "message": "Validation error",
  "details": [
    {
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

### 401 Unauthorized
```json
{
  "success": false,
  "error": "Unauthorized",
  "message": "Invalid or expired token"
}
```

### 403 Forbidden
```json
{
  "success": false,
  "error": "Forbidden", 
  "message": "Premium feature requires active subscription"
}
```

### 404 Not Found
```json
{
  "success": false,
  "error": "Not Found",
  "message": "Resource not found"
}
```

### 429 Too Many Requests
```json
{
  "success": false,
  "error": "Too Many Requests",
  "message": "Rate limit exceeded",
  "retryAfter": 60
}
```

### 500 Internal Server Error
```json
{
  "success": false,
  "error": "Internal Server Error",
  "message": "An unexpected error occurred"
}
```

---

## Rate Limiting

- Authentication endpoints: 5 requests per minute per IP
- General API endpoints: 100 requests per minute per user
- Export endpoints: 3 requests per hour per user
- Upload endpoints: 10 requests per minute per user

## Security Headers Required

All requests should include:
- `Content-Type: application/json` (except file uploads)
- `Authorization: Bearer {token}` (for protected endpoints)
- `X-API-Version: v1`
- `User-Agent: BetterBreaks/{version} ({platform})`

## Pagination

For endpoints that return lists, standard pagination is used:

**Query Parameters:**
- `limit`: number (default: 20, max: 100)
- `offset`: number (default: 0)

**Response includes:**
- `total`: total number of items
- `hasMore`: boolean indicating if more items are available
- `limit`: applied limit
- `offset`: applied offset

This API specification covers all the functionality observed in the BetterBreaks Flutter application, providing comprehensive endpoints for user management, break planning, analytics, experiences, and premium features.
