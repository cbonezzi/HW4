# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
   assert result
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_content(text)
  else
    assert page.has_content?(text)
  end
end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW3. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.


value = 0
Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
    value = 0
    movies_table.hashes.each do |movie|
      Movie.create movie
      value += 1
    end
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # You should arrange to add that movie to the database here.
    # You can add the entries directly to the databasse with ActiveRecord methodsQ
  end
#flunk "Unimplemented"

def table_cell(content)
  /.*<td>#{content}<\/td>.*/m
end
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(',')
    if uncheck 
      ratings.each{|rating| uncheck("ratings_" + rating)}
    else
      ratings.each{|rating| check("ratings_" + rating)}
    end
end
When /I follow "(.*)"$/ do |e1|
  click_on(e1)
end
When /^I click submit/ do
  click_on("ratings_"+ "submit")
end

Then /^I should see all of the movies$/ do
  allmovies = Movie.all
  allmovies.each do |movie|
    page.body =~ /.*#{movie.title}/m ? nil : raise("#{movie.title} Not Found")
  end
end
Then /^I should not see movies rated: (.*)/ do |ratings|
  ratings.split(',').each do |rating|
    page.body.should match table_cell(rating)
  end
end
Then /^I should see movies rated: (.*)/ do |ratings|
  ratings.split(',').each do |rating|
    page.body.should match table_cell(rating)
  end
end
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body =~ /#{e1}.*#{e2}/m, "#{e1} not before #{e2}"
end
#flunk "Unimplemented"



