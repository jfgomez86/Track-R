require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < Test::Unit::TestCase
  context "A given project" do

    setup do
      @project_id = $config[:project_1][:id]
      token_options = {:username => $config[:username], :password => $config[:password]}
      @tracker = Tracker.new(Token.new(token_options))
      @project = @tracker.project(@project_id)
    end

    should "show all stories for that project with @project.stories" do
      assert_equal 14, @project.stories.size
    end

    should "show a story with @project.story and passing the story id as argument" do 
      assert_equal $config[:story_1][:name], @project.story($config[:story_1][:id]).name
    end

    should "be able to add and remove a story" do 
      story_count = @project.stories.size
      attributes = { :name => "Finish Track-R (sorry for cluttering :))",
                    :requested_by => "Jose Felix Gomez", 
                    :description => "This story was made with Track-R library. Sorry for the clutter, you're free to delete me." }
      new_story = @project.create_story(attributes)
      assert_equal  "Finish Track-R (sorry for cluttering :))", new_story.name
      @project.delete_story(new_story)
      assert_equal story_count, @project.stories.size
    end

  end
end

