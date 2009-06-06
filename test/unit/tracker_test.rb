# project_id: 10490 (Koombea-Mañanero)
require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../lib/tracker'

class TestTrackerTest < Test::Unit::TestCase
  context "with a valid username and password" do

    setup do
      def token_options
        {:username => "XXXXXXXXXXXXXXXXXXXXXX", :password => "XXXXXXXX"}
      end
    end

    should "return a valid token" do
      @token = Tracker::Token.new(token_options)
      assert_equal "482260e8080106dd5a548ee5d494b0d4", @token.to_s
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
      @project_id = "XXXXX"
      def get_token
        token_options = {:username => "XXXXXXXXXXXXXXXXXXXXXX", :password => "XXXXXXXX"}
        Tracker::Token.new(token_options)
      end
    end

    should "return a valid project with correct attributes" do 
      @tracker = Tracker::Tracker.new(get_token)
      @project = @tracker.project(@project_id)
      assert_equal "Koombea ma&#241;anero", @project.name
      assert_equal %w(0 1 2 3), @project.point_scale
      assert_equal "Monday", @project.week_start_day
      assert_equal "1", @project.iteration_length
    end

  end

end
