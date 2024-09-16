CREATE TABLE Users (
  user_id INT PRIMARY KEY NOT NULL,
  username VARCHAR UNIQUE,
  email VARCHAR UNIQUE,
  password VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  phone_number VARCHAR,
  user_address VARCHAR,
);

CREATE TABLE Restaurants (
  restaurant_id INT PRIMARY KEY NOT NULL,
  name VARCHAR,
  description TEXT,
  location VARCHAR,
  rating DECIMAL(2,1),
  delivery_fee DECIMAL(10,2),
  minimum_order DECIMAL(10,2),
  user_id INT REFERENCES Users(user_id)
);

CREATE TABLE Categories (
  category_id INT PRIMARY KEY NOT NULL,
  name VARCHAR UNIQUE
);

CREATE TABLE Foods (
  food_id INT PRIMARY KEY NOT NULL,
  name VARCHAR,
  description TEXT,
  price DECIMAL(10,2),
  category_id INT REFERENCES Categories(category_id),
  restaurant_id INT REFERENCES Restaurants(restaurant_id),
  is_available VARCHAR DEFAULT 'yes' CHECK(is_available IN ('yes', 'no'))
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY NOT NULL,
  user_id INT REFERENCES Users(user_id),
  restaurant_id INT REFERENCES Restaurants(restaurant_id),
  order_date DATETIME,
  status VARCHAR CHECK(status IN ('pending', 'confirmed', 'cancelled', 'delivered')),
  total_price DECIMAL(10,2),
  delivery_address VARCHAR,
  payment_method VARCHAR CHECK(payment_method IN ('cash_on_delivery', 'online_transfer')),
  payment_status VARCHAR CHECK(payment_status IN ('pending', 'paid'))
);

CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY NOT NULL,
  order_id INT REFERENCES Orders(order_id),
  food_id INT REFERENCES Foods(food_id),
  quantity INT,
  price DECIMAL(10,2),
);

CREATE TABLE Reviews (
  review_id INT PRIMARY KEY NOT NULL,
  user_id INT REFERENCES Users(user_id),
  restaurant_id INT REFERENCES Restaurants(restaurant_id),
  order_id INT REFERENCES Orders(order_id),
  rating INT,
  comments TEXT,
);

CREATE TABLE Coupons (
  coupon_id INT PRIMARY KEY NOT NULL,
  code VARCHAR UNIQUE,
  discount_type VARCHAR CHECK(discount_type IN ('percentage', 'fixed_amount')),
  discount_value DECIMAL(10,2),
  minimum_order DECIMAL(10,2),
  expiry_date DATE
);

CREATE TABLE User_Coupons (
  user_coupon_id INT PRIMARY KEY NOT NULL,
  user_id INT REFERENCES Users(user_id),
  coupon_id INT REFERENCES Coupons(coupon_id),
  is_used VARCHAR DEFAULT 'no' CHECK(is_used IN ('yes', 'no'))
);

CREATE TABLE Order_Payments (
  order_payment_id INT PRIMARY KEY NOT NULL,
  order_id INT REFERENCES Orders(order_id),
  payment_gateway VARCHAR,  
  transaction_id VARCHAR
);