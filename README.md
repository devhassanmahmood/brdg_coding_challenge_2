# Task Contact options 

Command to run test cases `bundle exec rspec`

Rspec test all the scenario of the task

-> It checks when contact is created with personal email, it have base ranking which is 3

-> It checks when contact is NOT created with personal email, it have ranking 5

-> It checks when contact is NOT created with personal email, and already have some offering(s) it have ranking 6

-> It checks when we call sort_by_name function, it sort all contacts alphabetically by their last name, and then by their first name

-> It checks when we call offer_introduction function, it offer VIP intrdoction to contact has the highest ranking of all contacts who have NOT yet been offered a VIP introduction

-> It offer free intrdoction to contact that does NOT have the highest ranking of all contacts who have NOT yet been offered a VIP intro OR has already been offered one or more VIP intros


# validations

-> It validates email is present and unique and and valid and
-> It validates presence of first and last
  