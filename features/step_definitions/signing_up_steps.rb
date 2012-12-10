Given /^(?:|I )am on (.+)$/ do |page_name|
  # pending # express the regexp above with the code you wish you had
  visit path_to(page_name)
end

When /^I click Sign up$/ do
  # pending # express the regexp above with the code you wish you had
  click_link("Sign up")
  # visit('/login')
end

When /^I login$/ do
  # pending # express the regexp above with the code you wish you had
  # click_link("Sign up")
  #   And I fill in "Email" with "user@the-camp.org"
  # And I fill in "Password" with "passwords"
  # And I fill in "Password confirmation" with "passwords"
  # And I press "Sign up"
  # @user = User.create!(:name => 'Aslak', :password => 'xyz')
  # login(@user.name, @user.password)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  # pending # express the regexp above with the code you wish you had
  fill_in(field, :with => value)
end

When /^I press "(.*?)"$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  click_button(arg1)
end

Then /^I should see "(.*?)"$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # if page.respond_to? :should
  #   page.should have_content(arg1)
  # else
    assert page.has_content?(arg1)
  # end
end

