require File.dirname(__FILE__) + '/../test_helper'

class TestStoryTest < Test::Unit::TestCase

  context "A given story" do

    setup do
      token_options = {:username => $config[:username], :password => $config[:password]}
      @tracker = Tracker.new(Token.new(token_options))
      @project_id = $config[:project_1][:id]
      @project = @tracker.project(@project_id)
      attributes = { :name => "Finish Track-R (sorry for cluttering :))",
                    :requested_by => "Jose Felix Gomez",
                    :description => "This story was made with Track-R library. Sorry for the clutter, you're free to delete me." }
      @story = @project.create_story(attributes)
    end

    teardown do
      @project.delete_story(@story)
    end

    should "be updated after story.save call" do
      @story.name = "More power to the shields"
      @story.description = "ZOMG!"
      @story.save

      assert_equal "Combo Koombea ma&#241;aneo???", @project.story(@story.id).name
    end

  end
end

