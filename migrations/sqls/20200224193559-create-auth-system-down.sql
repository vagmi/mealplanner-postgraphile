/* Replace with your SQL commands */
drop function if exists mealplanner.authenticate(text, text);
drop function if exists mealplanner.register_person(text, text, text);
drop type mealplanner.jwt_token;
drop table mealplanner_private.person_account;
