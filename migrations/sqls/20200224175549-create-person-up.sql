/* Replace with your SQL commands */
create or replace function mealplanner.set_updated_at() returns trigger as $$
begin
  new.updated_at = current_timestamp;
  return new;
end;
$$ language plpgsql;

create table mealplanner.person (
  id bigserial primary key,
  name text not null,
  about text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create trigger person_set_updated_at before update
on mealplanner.person
for each row execute procedure mealplanner.set_updated_at();



