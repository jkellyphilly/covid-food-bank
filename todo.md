TODO's

1. Set up scope methods for DeliveryRequests, filtering by status
  a. These will be used on the "home" screen

2. Set up nested resource (delivery requests underneath CM)
  a. DONE - Set up the "index" first (i.e. community-members/3/delivery-requests)
  b. DONE - Set up a "new" form (i.e. community-members/3/delivery-requests/new)
  c. Do I want to have the ability to, if creating a form via the nested route, show the page under that profile again? I.e. if I just created delivery#5, do I want to be left on the page /community-members/:current_user_id/delivery-requests/:new_id

3. Build comment-functionality; comments are on DeliveryRequest pages ONLY

* Make a method to get a full list (hash) of items with their "count", then print that out on the route 

6. Update the CM and Volunteer "directories" to actually have some content on them

7. Make it so that a volunteer can EITHER mark an entire route as complete (which will automatically mark every delivery in that route as complete)... or you can do it manually, too
  - because, I think for confirmed->completed, it's just updating the value of the status... nothing else, because the route is already defined (and thus the volunteer)
