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
