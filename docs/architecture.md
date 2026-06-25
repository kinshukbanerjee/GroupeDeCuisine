# Groupe De Cuisine - System Architecture

## Version
1.0 MVP

---

# Overview
Groupe De Cuisine is a marketplace-style food ordering platform where customers can discover restaurants, browse menus, place orders, and make payments through a single mobile application.

Version 1 follows the principle:

> One Customer → One Cart → One Restaurant → One Order
Multi-restaurant ordering is intentionally deferred to a future release.

---

# High Level Architecture

```
+---------------------+
| Flutter Mobile App  |
+----------+----------+
           |
           | REST API
           |
+----------v----------+
| FastAPI Backend     |
+----------+----------+
           |
           |
+----------v----------+
| PostgreSQL Database |
+----------+----------+
           |
           |
+----------v----------+
| External Services   |
+---------------------+
| Firebase FCM        |
| Razorpay            |
+---------------------+
```

---

# Technology Stack

## Mobile Application
ComponentTechnologyFrameworkFlutterLanguageDartState ManagementRiverpodRoutingGoRouterNetworkingDioLocal StorageShared Preferences
---

## Backend
ComponentTechnologyAPI FrameworkFastAPILanguagePythonORMSQLAlchemyMigrationsAlembicValidationPydanticAPI DocumentationSwagger/OpenAPI
---

## Database
ComponentTechnologyDatabasePostgreSQLHostingDocker (Development)FutureManaged PostgreSQL
---

## Infrastructure
ComponentTechnologyVersion ControlGitHubCI/CDGitHub ActionsContainerizationDockerMonitoringFuture Phase
---

# User Roles

## Customer
Capabilities:

- Register/Login
- Browse Restaurants
- Browse Menus
- Manage Cart
- Place Orders
- Make Payments
- View Order History

---

## Restaurant Owner
Capabilities:

- Manage Restaurant Profile
- Manage Timings
- Manage Menu
- Accept/Reject Orders
- Update Order Status
- Create Promotions

---

## Delivery Partner (Future)
Capabilities:

- Accept Deliveries
- Update Delivery Status
- Navigation

---

## Super Admin (Future)
Capabilities:

- Manage Restaurants
- Manage Platform
- View Analytics

---

# Mobile Architecture
The Flutter application will follow Feature First Architecture.

```
app/lib/

├── core/
│   ├── api/
│   ├── constants/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── auth/
   ├── restaurants/
   ├── menu/
   ├── cart/
   ├── orders/
   └── profile/
│
├── shared/
│   ├── widgets/
   └── models/
│
├── routes/
│
└── main.dart
```
Benefits:

- Easier maintenance
- Scalable structure
- Separation of concerns
- Better testing

---

# Backend Architecture
The FastAPI application will follow a modular architecture.

```
backend/

app/
│
├── api/
│   ├── auth/
│   ├── restaurants/
│   ├── menu/
│   ├── cart/
│   ├── orders/
│   └── payments/
│
├── models/
│
├── schemas/
│
├── services/
│
├── database/
│
├── core/
│
└── main.py
```
Benefits:

- Clean separation
- Easier unit testing
- Scalable API development

---

# Core Database Entities

## Users
Stores:

- Customer Accounts
- Restaurant Owners
Fields:

- id
- role
- name
- mobile_number
- email
- created_at

---

## Restaurants
Stores:

- Restaurant Information
Fields:

- id
- owner_id
- name
- description
- address
- is_open
- created_at

---

## Restaurant Timings
Fields:

- id
- restaurant_id
- day_of_week
- opening_time
- closing_time
- override_status

---

## Menu Categories
Examples:

- Main Course
- Beverages
- Desserts
Fields:

- id
- restaurant_id
- name

---

## Menu Items
Fields:

- id
- category_id
- name
- description
- price
- image_url
- available

---

## Cart
Fields:

- id
- customer_id
- restaurant_id
Constraint:

One active cart per customer.

---

## Cart Items
Fields:

- id
- cart_id
- menu_item_id
- quantity

---

## Orders
Fields:

- id
- customer_id
- restaurant_id
- total_amount
- status
- payment_status
- created_at

---

## Order Items
Fields:

- id
- order_id
- menu_item_id
- quantity
- unit_price

---

## Payments
Fields:

- id
- order_id
- provider
- transaction_id
- amount
- status

---

# Order Lifecycle

```
Created
   |
Accepted
   |
Preparing
   |
Ready
   |
Completed
```
Alternative:

```
Created
   |
Rejected
```

---

# API Design Principles
Versioning:

```
/api/v1
```
Examples:

```
/api/v1/auth/login
/api/v1/restaurants
/api/v1/menu
/api/v1/cart
/api/v1/orders
```
Response Format:

Success:

{
"success": true,
"data": {}
}

Error:

{
"success": false,
"message": "Error Message"
}

---

# External Integrations

## Razorpay
Purpose:

- UPI Payments
- Credit Cards
- Debit Cards
Used In:

- Checkout
- Payment Verification

---

## Firebase Cloud Messaging
Purpose:

- Push Notifications
Examples:

- Order Accepted
- Order Rejected
- Order Ready

---

# Security Principles

- JWT Authentication
- HTTPS Only
- Input Validation
- SQL Injection Protection
- Password Hashing
- Role Based Authorization

---

# Testing Strategy

## Mobile

- Unit Tests
- Widget Tests
- Integration Tests

---

## Backend

- Unit Tests
- API Tests
- Database Tests

---

## CI/CD
GitHub Actions

Pipeline:

```
Commit
   |
Build
   |
Test
   |
Deploy
```

---

# Future Architecture Enhancements
Version 2

- QR Ordering
- Promotions
- Analytics Dashboard
- Google Sign-In
Version 3

- Delivery Partner Module
- Loyalty Program
- AI Recommendations
Version 4

- Multi-Restaurant Cart
- Multi-Restaurant Checkout
- Smart Routing
