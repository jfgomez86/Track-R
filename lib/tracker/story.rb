# TODO: Documentation ☻
class Story
  attr_reader :id, :story_type, :url, :estimate, :current_state,
    :description, :name, :requested_by, :owned_by, :created_at, :accepted_at,
    :labels
  def initialize(options = {})
    if options.include?(:project_id) && options.include?(:story_id) && options.include?(:token)
      @id         = options[:story_id]
      @project_id = options[:project_id]
      @token      = options[:token].to_s
      @url        = "http://www.pivotaltracker.com/story/show/#{@id}"
      @api_url    = "http://www.pivotaltracker.com/services/v2/projects/#{@project_id}/stories/#{@id}"
      @story      = Hpricot(open(@api_url, {"X-TrackerToken" => @token}))
    elsif options.include?(:story) && options.include?(:project_id)
      @project_id = options[:project_id]
      @story      = options[:story]
    else
      raise ArgumentError, "Valid options are: :story (receives an Hpricot Object) + :project_id OR :project_id + :story_id + :token"
    end
    build_story
  end

  def build_story
    @id            ||= @story.at('id').inner_html
    @url           ||= "http://www.pivotaltracker.com/story/show/#{@id}"
    @api_url       ||= "http://www.pivotaltracker.com/services/v2/projects/#{@project_id}/stories/#{@id}" 
    @story_type    = @story.at('story_type').inner_html    unless @story.at('story_type').nil?
    @estimate      = @story.at('estimate').inner_html      unless @story.at('estimate').nil?
    @current_state = @story.at('current_state').inner_html unless @story.at('current_state').nil?
    @description   = @story.at('description').inner_html   unless @story.at('description').nil?
    @name          = @story.at('name').inner_html          unless @story.at('name').nil?
    @requested_by  = @story.at('requested_by').inner_html  unless @story.at('requested_by').nil?
    @owned_by      = @story.at('owned_by').inner_html      unless @story.at('owned_by').nil?
    @created_at    = @story.at('created_at').inner_html    unless @story.at('created_at').nil?
    @accepted_at   = @story.at('accepted_at').inner_html   unless @story.at('accepted_at').nil?
    @labels        = @story.at('labels').inner_html        unless @story.at('labels').nil?
  end

end # class Tracker::Story
