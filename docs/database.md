# Groupe De Cuisine - Database Design

## Version

1.0 MVP

## Database Overview

Database Engine: PostgreSQL

Design Principles:

- Normalize data to 3NF
- Use UUIDs for primary keys
- Maintain audit fields
- Soft delete where applicable
- Design for future scalability

## Entity Relationship Diagram (Logical)

Users
  |
  +---- Restaurants
            |
            +---- RestaurantTimings
            |
            +---- MenuCategories
                        |
                        +---- MenuItems

Users
  |
  +---- Cart
            |
            +---- CartItems

Users
  |
  +---- Orders
            |
            +---- OrderItems
            |
            +---- Payments

## Common Audit Fields

Every business table should contain:

Field | Type
--- | ---
created_at | TIMESTAMP
updated_at | TIMESTAMP
created_by | UUID
updated_by | UUID

## Users

Purpose:

Stores Customers and Restaurant Owners.

### users

Field | Type | Constraints
--- | --- | ---
id | UUID | PK
role | VARCHAR(20) | CUSTOMER, OWNER
first_name | VARCHAR(100) | NOT NULL
last_name | VARCHAR(100) | 
mobile_number | VARCHAR(15) | UNIQUE
email | VARCHAR(255) | UNIQUE
password_hash | TEXT | NULL for OTP login
is_active | BOOLEAN | DEFAULT TRUE
created_at | TIMESTAMP | 
updated_at | TIMESTAMP | 

Indexes:

- idx_users_mobile
- idx_users_email
- idx_users_role

## Restaurants

Purpose:

Stores restaurant details.

### restaurants

Field | Type
--- | ---
id | UUID
owner_id | UUID
name | VARCHAR(255)
description | TEXT
address | TEXT
city | VARCHAR(100)
state | VARCHAR(100)
pincode | VARCHAR(20)
phone_number | VARCHAR(20)
logo_url | TEXT
banner_url | TEXT
is_open | BOOLEAN
is_active | BOOLEAN
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- owner_id → users.id

Indexes:

- idx_restaurants_owner
- idx_restaurants_name
- idx_restaurants_city

## Restaurant Timings

Purpose:

Stores daily operating hours.

### restaurant_timings

Field | Type
--- | ---
id | UUID
restaurant_id | UUID
day_of_week | INTEGER
opening_time | TIME
closing_time | TIME
override_status | BOOLEAN
override_reason | VARCHAR(255)
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- restaurant_id → restaurants.id

## Menu Categories

Purpose:

Organize menu items.

Examples:

- Starters
- Main Course
- Beverages

### menu_categories

Field | Type
--- | ---
id | UUID
restaurant_id | UUID
name | VARCHAR(100)
display_order | INTEGER
active | BOOLEAN
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- restaurant_id → restaurants.id

## Menu Items

Purpose:

Individual food items.

### menu_items

Field | Type
--- | ---
id | UUID
category_id | UUID
restaurant_id | UUID
name | VARCHAR(255)
description | TEXT
price | DECIMAL(10,2)
image_url | TEXT
available | BOOLEAN
preparation_time_minutes | INTEGER
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- category_id → menu_categories.id
- restaurant_id → restaurants.id

Indexes:

- idx_menu_items_restaurant
- idx_menu_items_category

## Cart

Purpose:

One active cart per customer.

### carts

Field | Type
--- | ---
id | UUID
customer_id | UUID
restaurant_id | UUID
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- customer_id → users.id
- restaurant_id → restaurants.id

Business Rule:

- One active cart per customer
- One restaurant per cart

### cart_items

Purpose:

Items added to a cart.

Field | Type
--- | ---
id | UUID
cart_id | UUID
menu_item_id | UUID
quantity | INTEGER
unit_price | DECIMAL(10,2)
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- cart_id → carts.id
- menu_item_id → menu_items.id

## Orders

Purpose:

Stores customer orders.

### orders

Field | Type
--- | ---
id | UUID
order_number | VARCHAR(30)
customer_id | UUID
restaurant_id | UUID
subtotal | DECIMAL(10,2)
tax_amount | DECIMAL(10,2)
discount_amount | DECIMAL(10,2)
total_amount | DECIMAL(10,2)
status | VARCHAR(30)
payment_status | VARCHAR(30)
notes | TEXT
created_at | TIMESTAMP
updated_at | TIMESTAMP

Relationships:

- customer_id → users.id
- restaurant_id → restaurants.id

Indexes:

- idx_orders_customer
- idx_orders_restaurant
- idx_orders_status

### order_items

Purpose:

Snapshot of purchased items.

Field | Type
--- | ---
id | UUID
order_id | UUID
menu_item_id | UUID
item_name | VARCHAR(255)
quantity | INTEGER
unit_price | DECIMAL(10,2)
line_total | DECIMAL(10,2)
created_at | TIMESTAMP

Important:

Store item name and price at order time to preserve historical accuracy.

Relationships:

- order_id → orders.id

### payments

Purpose:

Track payment transactions.

Field | Type
--- | ---
id | UUID
order_id | UUID
provider | VARCHAR(50)
provider_transaction_id | VARCHAR(255)
amount | DECIMAL(10,2)
currency | VARCHAR(10)
status | VARCHAR(30)
payment_method | VARCHAR(50)
created_at | TIMESTAMP

Relationships:

- order_id → orders.id

## Enumerations

### User Roles

- CUSTOMER
- OWNER
- ADMIN

### Order Status

- CREATED
- ACCEPTED
- PREPARING
- READY
- COMPLETED
- REJECTED
- CANCELLED

### Payment Status

- PENDING
- SUCCESS
- FAILED
- REFUNDED

## MVP Constraints

### Cart Rules

- One customer can have only one active cart.
- A cart can contain items from only one restaurant.

### Restaurant Rules

- A restaurant must have at least one menu category.
- A menu item must belong to exactly one category.

### Order Rules

- An order belongs to exactly one restaurant.
- An order belongs to exactly one customer.

## Future Tables (Version 2+)

- favorites
- reviews
- ratings
- discounts
- coupons
- advertisements
- notification_logs
- audit_logs

## Future Tables (Version 3+)

- delivery_partners
- deliveries
- delivery_tracking
- partner_earnings

## Database Design Decisions

### DD-001

Use UUIDs instead of auto-increment IDs.

Reason:

- Better security
- Easier distributed architecture
- Safer public APIs

### DD-002

Store historical order item prices.

Reason:

- Menu prices can change after purchase.

### DD-003

Restrict cart to one restaurant.

Reason:

- Simpler MVP architecture
- Faster delivery
- Easier testing
