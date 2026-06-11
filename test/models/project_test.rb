require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "is valid with all required attributes filled" do
    assert Project.build(name: "My project", description: "Lorem", logo: "foo.png").valid?
  end

  test "is invalid with missing name" do
    refute Project.build(logo: "foo.png", description: "Lorem").valid?
  end

  test "is invalid with missing logo" do
    refute Project.build(name: "My project", description: "Lorem").valid?
  end

  test "is invalid with missing description" do
    refute Project.build(name: "My project", logo: "foo.png").valid?
  end
end
