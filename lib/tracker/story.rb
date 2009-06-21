# TODO: Documentation ☻
class Story
  attr_accessor :story_type, :estimate, :current_state,
    :description, :name, :requested_by, :owned_by, :created_at, :accepted_at,
    :labels

  attr_reader :id, :url

  def initialize(options = {})
    @token      = options[:token].to_s
    if options.include?(:project_id) && options.include?(:story_id) && options.include?(:token)
      @id         = options[:story_id]
      @project_id = options[:project_id]
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

  def save
    parameters = build_story_xml
    api_url = URI.parse("http://www.pivotaltracker.com/services/v2/projects/#{@project_id}/stories/#{@id}")
    response = Net::HTTP.start(api_url.host, api_url.port) do |http|
      http.put(api_url.path, parameters, {'X-TrackerToken' => @token, 'Content-Type' => 'application/xml'})
    end

    @story = (Hpricot(response.body)/:story)
    build_story
  end

  protected

  def to_param
    query_string = attributes.map { |key, value| "story[#{key}]=#{CGI::escape(value)}" unless value.nil?}.compact.join('&')
  end

  def build_story_xml
    story_xml = "<story>"
    attributes.each do |key, value|
      story_xml << "<#{key}>#{(value.to_s)}</#{key}>" unless value.nil?
    end
    story_xml << "</story>"
  end

  def attributes
    {
      "story_type"    => @story_type,
      "estimate"      => @estimate,
      "current_state" => @current_state,
      "description"   => @description,
      "name"          => @name,
      "requested_by"  => @requested_by,
      "owned_by"      => @owned_by,
      "labels"        => @labels
    }
  end
end # class Tracker::Story
