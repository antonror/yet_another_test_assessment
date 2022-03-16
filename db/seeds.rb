# seed instances
(1..2).each do |number|
  user = User.create!(email: "user_#{number}@test.test")
  p "Created user with #{user.email} identifier"
end

# success case
success_case_readings = [36.5, 36.6, 36.7, 36.8, 36.9]
success_case_readings.each do |reading|
  first_user = User.first
  Temperature.create!(user: first_user, value: reading)
  p "Created #{reading} C reading for user with #{first_user.email} identifier"
end

# fail scenario
fail_scenario_readings = [36.1, 36.2, 36.3, 36.4, 36.5]
fail_scenario_readings.each do |reading|
  last_user = User.last
  Temperature.create!(user: last_user, value: reading)
  p "Created #{reading} C reading for user with #{last_user.email} identifier"
end


offset = Offset.create!(value: 0.1)
p "Global offset was set to #{offset.value} C"
