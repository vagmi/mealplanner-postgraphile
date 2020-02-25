/* Replace with your SQL commands */
create extension if not exists "pgcrypto";

create table mealplanner_private.person_account (
  person_id bigint primary key references mealplanner.person(id) on delete cascade,
  email text not null unique,
  password_hash text not null
);
comment on table mealplanner_private.person_account is 'Private information about person account';

create or replace function mealplanner.register_person(
  name text,
  email text,
  password text
) returns mealplanner.person as $$
declare
  person mealplanner.person;
begin
  insert into mealplanner.person (name) values (name)
  returning * into person;

  insert into mealplanner_private.person_account (person_id, email, password_hash) values
  (person.id, email, crypt(password, gen_salt('bf')));
  return person;
end;
$$ language plpgsql strict security definer;

create type mealplanner.jwt_token as (
  role text,
  person_id bigint,
  exp bigint
);

create or replace function mealplanner.authenticate(
  email text,
  password text
) returns mealplanner.jwt_token as $$
declare
  account mealplanner_private.person_account;
begin
  select a.* into account
  from mealplanner_private.person_account as a
  where a.email = $1;

  if account.password_hash = crypt(password, account.password_hash) then
    return (
      'mealplanner_person', 
      account.person_id, 
      extract(epoch from (now() + interval '7 days')))::mealplanner.jwt_token;
  else
    return null;
  end if;
end;
$$ language plpgsql strict security definer;
