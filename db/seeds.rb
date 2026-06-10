# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Work history shown in the Resume sidebar on the homepage. Dates are
# month-precision from LinkedIn (stored as the first of the month).
[
  { company: "Productboard", role: "Senior Software Engineer", logo: "productboard.jpeg", started_on: Date.new(2021, 1, 1), ended_on: Date.new(2026, 5, 1) },
  { company: "Panoramic", role: "Full Stack Engineer", logo: "panoramic.jpeg", started_on: Date.new(2018, 5, 1), ended_on: Date.new(2020, 11, 1) },
  { company: "GoodData", role: "Principal Software Engineer", logo: "gooddata.jpeg", started_on: Date.new(2014, 7, 1), ended_on: Date.new(2018, 4, 1) },
  { company: "Proof & Reason", role: "Web Developer", logo: "proof-and-reason.jpeg", started_on: Date.new(2012, 6, 1), ended_on: Date.new(2014, 7, 1) }
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
