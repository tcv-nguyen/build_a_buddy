Start: 18:16 Central Time

# About the project:

Build a Buddy is a toy store that provides customers with a fun and creative way to personalize stuffed animals. The customer begins by choosing a stuffed animal, and then selecting accessories to customize their look. When the customer is satisfied with their selections, an employee will fill the stuffed animal with padding, and affix all the accessories. After assembly is complete, the customer pays the “adoption fee” and gives their new buddy a name.

# Notes:

- For demo purpose, the project is ready for development environment only. For production environment, it would require extra settings.
- For demo purpose, I add `cost` and `sale_price` into the StuffedAnimal and Accessory tables. In production mode, where there are a lot of different products and variants, I would break the `cost` and `sale_price` into Money object.
- For demo purpose, I add `quantity` into table StuffedAnimal and Accessory. In reality, I should create model Inventory separately because of normalization and client could have multiple warehouses, plus other Inventory's attributes.
