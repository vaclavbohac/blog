require "test_helper"

class WorkExperienceTest < ActiveSupport::TestCase
  test "ordered returns most recent roles first" do
    older = WorkExperience.create!(company: "Older Co", role: "Dev", logo: "older.svg", started_on: Date.new(2010, 1, 1))
    newer = WorkExperience.create!(company: "Newer Co", role: "Dev", logo: "newer.svg", started_on: Date.new(2020, 1, 1))

    ordered = WorkExperience.where(company: [ older.company, newer.company ]).ordered.to_a

    assert_equal [ newer, older ], ordered
  end

  test "ongoing? is true when there is no end date" do
    assert WorkExperience.new(ended_on: nil).ongoing?
    assert_not WorkExperience.new(ended_on: Date.current).ongoing?
  end

  test "is valid with the required attributes" do
    experience = WorkExperience.new(company: "Planetaria", role: "CEO", logo: "planetaria.svg", started_on: Date.new(2019, 1, 1))

    assert experience.valid?
  end

  test "requires company, role, logo and started_on" do
    experience = WorkExperience.new

    assert_not experience.valid?
    assert_includes experience.errors.attribute_names, :company
    assert_includes experience.errors.attribute_names, :role
    assert_includes experience.errors.attribute_names, :logo
    assert_includes experience.errors.attribute_names, :started_on
  end

  test "is invalid when ended_on is before started_on" do
    experience = WorkExperience.new(company: "Planetaria", role: "CEO", logo: "planetaria.svg", started_on: Date.new(2019, 1, 1), ended_on: Date.new(2018, 1, 1))

    assert_not experience.valid?
    assert_includes experience.errors.attribute_names, :ended_on
  end

  test "is valid when ended_on equals started_on" do
    experience = WorkExperience.new(company: "Planetaria", role: "CEO", logo: "planetaria.svg", started_on: Date.new(2019, 1, 1), ended_on: Date.new(2019, 1, 1))

    assert experience.valid?
  end
end
