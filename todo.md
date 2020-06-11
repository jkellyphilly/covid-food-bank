TODO's

* Make a method to get a full list (hash) of items with their "count", then print that out on the route

* Update the CM and Volunteer "directories" to actually have some content on them

* Update the "delete" forms to follow this standard/convention
  - https://learn.co/tracks/full-stack-web-development-v8/module-13-rails/section-6-validations-and-forms/delete-forms

* Maybe all of my helper methods should be snake case and not camelCase

* Define full update_status logic

NEXT
* Ability to delete requests

-----------------
ASIDE

  It seems like there are definitely some limitations here... for instance, if I want to update a delivery request from a past date, then my current date validation method prevents me from doing that.







TALK THROUGH
1) Show signing up as a community member (with errors)
2) Log out and try to navigate to a page (doesn't work)
3) Try to sign in (unsuccessfully)
4) Sign in and edit your own profile (unsuccessfully, then success)
5) Try to edit someone else's profile
6) Create a delivery request (show errors, then success)
7) Edit the request
8) Log in as volunteer (w/ Github) - add that request to my route
9) Show what happens when I mark a route as completed (all deliveries marked as completed)
10) Update the route to not completed (all are back to confirmed)
11) Delete the route (show that the deliveries now don't have a route associated)
  - But first, leave a comment and say that I'm sorry that I can't make it, deleting the route
12) Then log in as a CM and delete one of those requests
