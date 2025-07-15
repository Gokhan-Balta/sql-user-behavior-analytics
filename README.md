# User Behavior SQL Analytics Project

This project analyzes user behavior in an e-commerce-like environment using advanced SQL techniques in PostgreSQL.  
It focuses on **EDA**, **conversion funnels** and **segmentation**.

---

## Objectives

- Analyze user interactions from session to purchase.
- Identify behavioral patterns across gender and location.
- Prepare data for recommendation engines.

---

## Database Schema

Relational schema used in the project:

| Table Name    | Description                      | Primary Key              | Foreign Keys                                                                |
|---------------|----------------------------------|--------------------------|-----------------------------------------------------------------------------|
| `users`       | User demographic info            | `user_id`                | –                                                                           |
| `products`    | Product catalog                  | `product_id`             | –                                                                           |
| `sessions`    | User login sessions              | `session_id`             | `user_id → users.user_id`                                                   |
| `pageviews`   | Product pages viewed in sessions | `view_id`                | `session_id → sessions.session_id`  <br> `product_id → products.product_id` |
| `cart_events` | Products added to cart           | `event_id`               | `session_id → sessions.session_id`  <br> `product_id → products.product_id` |
| `purchases`   | Completed purchases              | `purchase_id`            | `user_id → users.user_id`  <br> `product_id → products.product_id`          |

> All tables are properly normalized and connected via foreign keys.

---

## Analysis Summary

### 1. Exploratory Data Analysis
- Number of users, products, sessions, pageviews, cart_events, purchases
- Top 10 products with the most page views
- Most purchased products
- How many users from which city?
- average session duration

### 2. Funnel Analysis
- Create a user-level funnel view showing who started a session, viewed a product, added to cart, and made a purchase
- Compute conversion rates for each funnel stage across all users

### 3. Product-Level Conversion
- Analyze conversion funnel at the product level
- View-to-purchase rates

### 4. Cart Behavior by Gender
- Compare number of cart actions per gender
- Compare average price of added-to-cart products per gender


---

## 💻 Tools Used

- SQL (PostgreSQL)
- pgAdmin for database management
- VS Code for SQL editing

---

## 📈 Example Output

> View to Purchase Conversion for Top Products:

| Product Name      |  Views | adds_to_cart | Purchases | view_to_cart_rate | cart_to_purchase_rate | view_to_purchase_rate |
|-------------------|--------|--------------|-----------|-------------------|-----------------------|-----------------------|
| MSI Gaming Laptop | 184    | 71           | 22        | 38.59             |  30.99                | 11.99                 |
| Steam Deck        | 172    | 36           | 32        | 20.93             |  88.89                | 18.60                 |



---

## Learnings

- Advanced SQL joins, aggregations, and CTEs
- Behavior funnel and conversion metric calculation
- Data structuring for recommendation engines

---



