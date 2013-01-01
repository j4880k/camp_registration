A Camp Registration Application.

This application is intended to provide the following:

 * Authentication - done with devise
 * Authorization - done with cancan
 * A way for users to schedule themselves / others for events going on at the camp.
 * A way for users to pay for reservations / events going on at the camp. (If by check the reservation is only a stub and not a guarantee until check arrives to registrar.)
 * A way for administration to manage all camp objects
 * A way for the registrar to manage events, resources, staff and reservation confirmations.
 * A way for camp staffers to add notes into the system on various levels. Most important will be for the nurse to be able to create notes.

Notes:
 2012.12.10 - initial commit. the code isn't very clean right now but this will allow some sharing for the benefit of non-technical team members. 
 From paranoia I left some files out that you will need to create if you build this up like :
 config/initializers/secret_token.rb

 2012.12.12 - Decent progress on a simple shopping cart experience.  

 2012.12.31 - 
 * Progress checks for required fields, this way the person can save incomplete. Reservation links disabled until complete.
 * Invoices can be cancelled.
 * CHANGED : Limited use coupons now apply per line instead of per invoice. (so single use discounts will only apply to first line)
 * Fixed quite a few reported bugs and feature requests.