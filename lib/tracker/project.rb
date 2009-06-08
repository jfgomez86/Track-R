class Project
  attr_reader :name, :iteration_length, :id, :week_start_day, :point_scale, :api_url, :url, :token
  def initialize(options = {})
    if options.include?(:project_id) && options.include?(:token)
      @id      = options[:project_id]
      @token   = options[:token].to_s
      @api_url = "http://www.pivotaltracker.com/services/v2/projects/#{@id}"
      @url     = "http://www.pivotaltracker.com/projects/#{@id}"
      @project = Hpricot(open(@api_url, {"X-TrackerToken" => token}))
    elsif options.include?(:project)
      @project = options[:project]
    else
      raise ArgumentError, "Valid options are: :project (receives an Hpricot Object) OR :project_id + :token"
    end
    build_project
  end

  def build_project
    @id               ||= @project.at('id').inner_html
    @api_url          ||= "http://www.pivotaltracker.com/services/v2/projects/#{@id}"
    @url              ||= "http://www.pivotaltracker.com/projects/#{@id}"
    @name             = @project.at('name').inner_html
    @iteration_length = @project.at('iteration_length').inner_html
    @week_start_day   = @project.at('week_start_day').inner_html
    @point_scale      = @project.at('point_scale').inner_html.split(',')
  end

end # class Tracker::Project
