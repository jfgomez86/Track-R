# The class is a wrapper for getting projects, stories and using tokens.  It's
# main purpose is relating the three allowing to interact with a project, and
# its stories using a token.
# Expects a token when initialized.
class Tracker

  # To generate a token, use the "Create New Token" link on the My Profile
  # page (http://www.pivotaltracker.com/profile).
  def initialize(token)
    @token = token
    raise TypeError unless @token.is_a? Token
  end

  # Fetches project with given ID
  # Returns a Project object
  def project(project_id)
    @project = Project.new(:project_id => project_id , :token => @token)
  end

  # Refresh the projects from the server
  # Returns an array of projects
  def sync
    @projects = nil
    get_projects
  end

  # Alias for get_projects
  # Returns an array of projects
  def projects ; get_projects ; end

  # Receives a block with the condition to find a project. Should work the
  # same as Enumerable.find method
  # Returns a Project object
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
    @projects ||= (Hpricot(open(api_url, {"X-TrackerToken" => @token.to_s}))/:project).map {|project| Project.new(:project => project, :token => @token)}
  end

end # class Tracker::Tracker
