Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  director.should be == movie.director
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(%r{,\s*}).each do |rating|
    check = !uncheck
    if check then
      check("ratings_#{rating}")
    else
      uncheck("ratings_#{rating}")
    end
  end
end


Then /I should( not)? see: (.*)/ do |not_present, title_list|
  titles = title_list.split(%r{,\s*})
  titles.each do |title|
    present = !not_present
    if present then
      page.should have_content(title)
    else
      page.should_not have_content(title)
    end
   end
end

Then /I should see all the movies/ do
  all("table#movies tbody tr").count.should == Movie.count
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  e1_position = page.body.index(e1)
  e2_position = page.body.index(e2, e1_position)
  (e1_position != nil && e2_position != nil && e1_position < e2_position).should == true
end