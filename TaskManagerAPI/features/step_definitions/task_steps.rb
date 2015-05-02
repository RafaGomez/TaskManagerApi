Given(/^a system with the following tasks$/) do |table|
  Task.delete_all

  table.hashes.each do |attributes|
    Task.create!(attributes)
  end
end

When(/^the user request a list of (.+)$/) do |model|
  get (model)
end

Then(/^the response is a list with (\d+) tasks$/) do |arg1|
  data = MultiJson.load(last_response.body)
  data.count.should == arg1.to_i
end

Then(/^one task has the following attributes:$/) do |table|
  data = MultiJson.load(last_response.body)
  expected_item = table.hashes.each_with_object({}) do |row, hash|
    name, value, type = row["attribute"], row["value"], row["type"]
    
    data = data.select{ |item| item[name].to_s == value.to_s}
  end
  expect(data.count).to eq(1)
end


When(/^the user sends a POST request to "(.*?)" with the following:$/) do |url, body|
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  post url, body
end

Then(/^the response status should be "(.*?)"$/) do |status|
  last_response.status.should == status.to_i
end

Then(/^the response body should be a task like:$/) do |table|
  # table is a Cucumber::Ast::Table
    data = JSON.load(last_response.body)
  expected_item = table.hashes.each_with_object({}) do |row, hash|
    name, value, type = row["attribute"], row["value"], row["type"]
    data[name].to_s.should == value.to_s
  end
end


When(/^the user sends a DELETE request to "(.*?)":$/) do |url|
  delete url
end

Then(/^task (\d+) should be deleted$/) do |taskID|
  expect {Task.find(taskID)}.to raise_error
end