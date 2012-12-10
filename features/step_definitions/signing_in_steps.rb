Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  # pending # express the regexp above with the code you wish you had
        table.hashes.each do |attributes|
          unconfirmed = attributes.delete("unconfirmed") == "true"
          @user = User.create!(attributes)
          @user.confirm! unless unconfirmed
          # @user = User.create!(attributes)
        end
end

When /^(?:|I )follow "([^\"]*)"$/ do |link|
  click_link(link)
end


# Then /^I should see "(.*?)"$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # if page.respond_to? :should
    # page.should have_content(arg1)
  # else
    # assert page.has_content?(arg1)
  # end
# end