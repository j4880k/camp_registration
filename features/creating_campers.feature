# Given I am on the homepage
# And there are the following users:
# | email             | password |
# | user@ticketee.com | password |
# And I am on the homepage
# When I follow "Internet Explorer"
# And I follow "New Ticket"
#         Then I should see "You need to sign in or sign up before continuing."
#         When I fill in "Email" with "user@ticketee.com"
#         And I fill in "Password" with "password"
#         And I press "Sign in"
#         Then I should see "New Ticket"