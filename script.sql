create table restaurant (
  id integer primary key,
  name varchar(20),
  description varchar(100),
  phone char(10),
  rating decimal,
  hours varchar(100)
);

create table address (
  id integer primary key,
  street_number varchar(10),
  street_name varchar(20),
  city varchar(20),
  state varchar(20),
  gmaps_link varchar(60),
  restaurant_id  integer REFERENCES restaurant(id) UNIQUE
);

select constraint_name, table_name, column_name
from information_schema.key_column_usage
where table_name = 'restaurant' or table_name = 'address' ;

create table category (
  id char(2) primary key,
  name varchar(20),
  description varchar(200)
);

select constraint_name, table_name, column_name
from information_schema.key_column_usage
where table_name = 'category';

create table dish (
  id integer primary key,
  name varchar(50),
  description varchar(200),
  spicy boolean
);


select constraint_name, table_name, column_name
from information_schema.key_column_usage
where table_name = 'dish';


create table review (
  id integer primary key,
  rating decimal,
  description varchar(100),
  date date,
  restaurant_id integer references restaurant(id)
);

select constraint_name, table_name, column_name
from information_schema.key_column_usage
where table_name = 'review';

select constraint_name, table_name, column_name
from information_schema.key_column_usage
where  table_name='address';

create table categories_dishes (
  category_id char(2) references category(id) ,
  dish_id integer references dish(id),
  price money,
  primary key (category_id, dish_id)
);
 
 --------------------------------------------
 Insert values for restaurant
 --------------------------------------------
 
INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 900 am to 900 pm, Weekends 1000 am to 1100 pm'
);

 
 --------------------------------------------
 Insert values for address
 --------------------------------------------
 
INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'httpbit.lyBytesOfChina',
  1
);

 
 --------------------------------------------
 Insert values for review
 --------------------------------------------
 
INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

 
 --------------------------------------------
 Insert values for category
 --------------------------------------------
 
INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 1100 am and 300 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

 
 --------------------------------------------
 Insert values for dish
 --------------------------------------------
 
INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);


 --------------------------------------------
 Insert valus for cross-reference table, categories_dishes
 --------------------------------------------
 
INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);
--10
Select restaurant.name , address.street_name , address.street_number , restaurant.phone
from restaurant join address on restaurant.id = address.restaurant_id;


select max(review.rating) as best_rating from review join restaurant on review.restaurant_id = restaurant.id;

select dish.name as dish_name , categories_dishes.price as price, category.name as category
from dish join categories_dishes on  categories_dishes.dish_id = dish.id
join category on categories_dishes.category_id = category.id order by 1;

select category.name as category , dish.name as dish_name , categories_dishes.price as price
from category join categories_dishes on categories_dishes.category_id = category.id
join dish on categories_dishes.dish_id = dish.id
order by category.name ;

select dish.name as spicy_dish_name, category.name as category, categories_dishes.price as price
from dish join categories_dishes on
categories_dishes.dish_id = dish.id
join category on categories_dishes.category_id = category.id where dish.spicy is true;

select dish_id , count(dish_id) as dish_count
from categories_dishes
group by 1;

select dish_id , count(dish_id) as dish_count
from categories_dishes
group by 1
having count(dish_id)  1;

select dish.name  as dish_name, count(dish_id) as dish_count
from categories_dishes join dish on dish.id = categories_dishes.dish_id
group by 1
having count(dish_id)  1;

select rating as best_rating , description
from review
where rating  = (select 
max(rating) from review);