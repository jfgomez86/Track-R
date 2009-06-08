class Tracker

  # To generate a token, use the "Create New Token" link on the My Profile
  # page (http://www.pivotaltracker.com/profile).
  def initialize(token)
    @token = token
    raise TypeError unless @token.is_a? Token
  end

  # Fetches project with given ID
  def project(project_id)
    @project = Project.new(:project_id => project_id , :token => @token)
  end

  # Refresh the projects from the server
  def sync
    @projects = nil
    get_projects
  end

  # Alias for get_projects
  def projects ; get_projects ; end

  # Receives a block with the condition to find a project. Should work the
  # same as Enumerable.find method
  def find_project
    get_projects unless defined?(@projects) && @projects.is_a?(Array)
    @projects.find do |project|
      yield(project)
    end
  end

  protected

  # Fills @projects. NOTE: call sync method to refill/sync @projects
  # Returns an Array stored in @projects
  def get_projects
    api_url = "#{CONFIG[:api_location]}/projects/"
    @projects ||= (Hpricot(open(api_url, {"X-TrackerToken" => @token.to_s}))/:project).map {|project| Project.new(:project => project)}
  end

end # class Tracker::Tracker
