# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Work history shown in the Resume sidebar on the homepage.
[
  { company: "Planetaria", role: "CEO", logo: "planetaria.svg", started_on: Date.new(2019, 1, 1), ended_on: nil },
  { company: "Airbnb", role: "Product Designer", logo: "airbnb.svg", started_on: Date.new(2014, 1, 1), ended_on: Date.new(2019, 1, 1) },
  { company: "Facebook", role: "iOS Software Engineer", logo: "facebook.svg", started_on: Date.new(2011, 1, 1), ended_on: Date.new(2014, 1, 1) },
  { company: "Starbucks", role: "Shift Supervisor", logo: "starbucks.svg", started_on: Date.new(2008, 1, 1), ended_on: Date.new(2011, 1, 1) }
].each do |attrs|
  WorkExperience.find_or_create_by!(company: attrs[:company]) do |experience|
    experience.assign_attributes(attrs)
  end
end

# Admin user for content management. In production the credentials must be
# provided explicitly; outside production a default is created for convenience.
admin_email = ENV["ADMIN_EMAIL"]
admin_password = ENV["ADMIN_PASSWORD"]

if admin_email && admin_password
  User.find_or_create_by!(email_address: admin_email) { |u| u.password = admin_password }
elsif !Rails.env.production?
  User.find_or_create_by!(email_address: "admin@example.com") { |u| u.password = "password" }
end
