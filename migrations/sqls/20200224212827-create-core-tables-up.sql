/* Replace with your SQL commands */
begin;
  create table mealplanner.dish (
    id bigserial primary key,
    name text not null,
    description text,
    created_at timestamp default now(),
    updated_at timestamp default now()
  );

  comment on table mealplanner.dish is 'A yummy tasty dish';

  create trigger dish_set_updated_at before update
  on mealplanner.dish
  for each row execute procedure mealplanner.set_updated_at();

  create table mealplanner.dish_nutrition (
    id bigserial primary key,
    dish_id bigint unique not null references mealplanner.dish(id) on delete cascade,
    serving_size numeric not null,
    serving_unit text not null,
    calories numeric,
    total_fat numeric,
    total_fat_dv numeric,
    saturated_fat numeric,
    saturated_fat_dv numeric,
    trans_fat numeric,
    trans_fat_dv numeric,
    cholestrol numeric,
    cholestrol_dv numeric,
    sodium numeric,
    sodium_dv numeric,
    total_carbohydrates numeric,
    total_carbohydrates_dv numeric,
    dietary_fiber numeric,
    dietary_fiber_dv numeric,
    total_sugars numeric,
    total_sugars_dv numeric,
    added_sugars numeric,
    added_sugars_dv numeric,
    protein numeric,
    protein_dv numeric,
    vitamin_d numeric,
    vitamin_d_dv numeric,
    calcium numeric,
    calcium_dv numeric,
    iron numeric,
    iron_dv numeric,
    pottasium numeric,
    pottasium_dv numeric,
    created_at timestamp default now(),
    updated_at timestamp default now()
  );

  comment on table mealplanner.dish_nutrition is 'Nutrition details for a dish';

  create trigger dish_nutrition_set_updated_at before update
  on mealplanner.dish_nutrition
  for each row execute procedure mealplanner.set_updated_at();

  create table mealplanner.ingredient (
    id bigserial primary key,
    name text not null,
    description text,
    created_at timestamp default now(),
    updated_at timestamp default now()
  );

  create trigger ingredient_set_updated_at before update
  on mealplanner.ingredient
  for each row execute procedure mealplanner.set_updated_at();

  create table mealplanner.recipe (
    id bigserial primary key,
    instructions text,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
  );

  create trigger recipe_set_updated_at before update
  on mealplanner.recipe
  for each row execute procedure mealplanner.set_updated_at();

  create table mealplanner.recipe_measure (
    id bigserial primary key,
    ingredient_id bigint not null references mealplanner.ingredient(id) on delete cascade,
    dish_id bigint not null references mealplanner.dish(id) on delete cascade,
    quantity numeric,
    measure text
  );
commit;
