Start: 05/16/2019 6:16 PM Central Time
Extracting data: 05/16/2019 8:19 PM Central Time
Taking break: 05/16/2019 9:56 PM Central Time
Resume: 05/17/2019 8:40 AM Central Time
End: 05/17/2019 12:44 PM Central Time

# About the project:

Build a Buddy is a toy store that provides customers with a fun and creative way to personalize stuffed animals. The customer begins by choosing a stuffed animal, and then selecting accessories to customize their look. When the customer is satisfied with their selections, an employee will fill the stuffed animal with padding, and affix all the accessories. After assembly is complete, the customer pays the “adoption fee” and gives their new buddy a name.

# Notes:

- For demo purpose, the project is ready for development environment only. For production environment, it would require extra settings.
- For demo purpose, I add `cost` and `sale_price` into the StuffedAnimal and Accessory tables. In production mode, where there are a lot of different products and variants, I would break the `cost` and `sale_price` into Money object.
- For demo purpose, I add `quantity` into table StuffedAnimal and Accessory. In reality, I should create model Inventory separately because of normalization and client could have multiple warehouses, plus other Inventory's attributes.
- I'll create association:
  - Order has_many CustomProduct
  - CustomProduct belongs_to StuffedAnimal, has_many Accessories through ProductAccessory. ProductAccessory will have Accessory sale_price at the time of adding to cart.
  - This association will allow normalization of Order with multiple CustomProducts, allow developer easy to code on front end for User's seletion, allow simple controller add/remove CustomProduct, allow simple calculation of CustomProduct's price (sum :quantity)
- I'll use CustomProduct model to generate object for calculation profit, then I'll collect the best 3 CustomProduct with most profit

# Instructions:

- Run `rake db:create db:migrate db:seed` to generate seed data
