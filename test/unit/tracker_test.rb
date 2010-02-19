require File.dirname(__FILE__) + '/../test_helper'

class TestTrackerTest < Test::Unit::TestCase

  context "with an invalid token" do

    should "raise an TypeError if token is other than TrackR::Token object" do
      token = "token"
      assert_raise(TypeError) { TrackR::Tracker.new(token) }
    end

  end

  context "with a valid token" do

    setup do
      @project_id = $config[:project_1][:id]
      def get_token
        token_options = {:username => $config[:username], :password => $config[:password]}
        TrackR::Token.new(token_options)
      end
      @tracker = TrackR::Tracker.new(get_token)
    end

    should "return a valid project by passing the id with correct attributes" do
      project = @tracker.project(@project_id)
      assert_equal $config[:project_1][:name], project.name
      assert_equal $config[:project_1][:point_scale], project.point_scale
      assert_equal $config[:project_1][:week_start_day], project.week_start_day
      assert_equal $config[:project_1][:iteration_length], project.iteration_length
    end

    should "return an array of all my projects" do
      projects = @tracker.projects
      assert_equal $config[:project_count], projects.size
    end

    should "be able to find a project using Enumerable.find method" do
      project_1 = (@tracker.find_project {|project| project.name == $config[:project_1][:name]})
      project_2 = (@tracker.find_project {|project| project.id == $config[:project_2][:id]})
      assert_equal $config[:project_1][:name], project_1.name, "Failed to find by name"
      assert_equal $config[:project_2][:name], project_2.name, "Failed to find by id"
    end
  end

end
