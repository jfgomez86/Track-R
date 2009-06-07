# project_id: 10490 (Koombea-Mañanero)
require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../lib/tracker'

class TestTrackerTest < Test::Unit::TestCase
  @@config = YAML.load_file(File.join(File.dirname(__FILE__), '/../test_config.yml'))

  context "with a valid username and password" do

    setup do
      def token_options
        {:username => @@config[:username], :password => @@config[:password]}
      end
    end

    should "return a valid token" do
      @token = Tracker::Token.new(token_options)
      assert_equal @@config[:token], @token.to_s
    end

  end

  context "with an invalid token" do 

    should "raise an TypeError if token is other than Tracker::Token object" do 
      token = "token"
      assert_raise(TypeError) { Tracker::Tracker.new(token) }
    end

  end

  context "with a valid token" do

    setup do
      @project_id = @@config[:project_1][:id]
      def get_token
        token_options = {:username => @@config[:username], :password => @@config[:password]}
        Tracker::Token.new(token_options)
      end
      @tracker = Tracker::Tracker.new(get_token)
    end

    should "return a valid project with correct attributes" do 
      project = @tracker.project(@project_id)
      assert_equal @@config[:project_1][:name], project.name
      assert_equal @@config[:project_1][:point_scale], project.point_scale
      assert_equal @@config[:project_1][:week_start_day], project.week_start_day
      assert_equal @@config[:project_1][:iteration_length], project.iteration_length
    end

    should "return an array of all my projects" do 
      projects = @tracker.projects
      assert_equal @@config[:project_count], projects.size
    end

    should "be able to find a project using Enumerable.find method" do 
      project_1 = (@tracker.find_project {|project| project.name == @@config[:project_1][:name]})
      project_2 = (@tracker.find_project {|project| project.id == @@config[:project_2][:id]})
      assert_equal @@config[:project_1][:name], project_1.name, "Failed to find by name"
      assert_equal @@config[:project_2][:name], project_2.name, "Failed to find by id"
    end
  end

end
