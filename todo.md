TODO's

1. Set up scope methods for DeliveryRequests, filtering by status
  a. These will be used on the "home" screen

2. Set up nested resource (delivery requests underneath CM)
  a. DONE - Set up the "index" first (i.e. community-members/3/delivery-requests)
  b. DONE - Set up a "new" form (i.e. community-members/3/delivery-requests/new)
  c. Do I want to have the ability to, if creating a form via the nested route, show the page under that profile again? I.e. if I just created delivery#5, do I want to be left on the page /community-members/:current_user_id/delivery-requests/:new_id

3. Build comment-functionality; comments are on DeliveryRequest pages ONLY

4. Ensure that users can only edit their own profiles
