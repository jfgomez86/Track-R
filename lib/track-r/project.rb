module TrackR
  # Container for project's attributes.
  # Receives a hash with either :project key pointing to an hpricot object or a
  # project_id and a token with which to fetch and build the project object
  class TrackR::Project
    attr_reader :name, :iteration_length, :id, :week_start_day, :point_scale,
      :api_url, :url, :token

    def initialize(options = {})
      if options.include?(:project_id) && options.include?(:token)
        @id      = options[:project_id]
        @token   = options[:token].to_s
        @api_url = "#{CONFIG[:api_url]}projects/#{@id}"
        @url     = "http://www.pivotaltracker.com/projects/#{@id}"
        @project = Hpricot(open(@api_url, {"X-TrackerToken" => @token}))
        @stories = nil
      elsif options.include?(:project) && options.include?(:token)
        @project = options[:project]
        @token   = options[:token].to_s
      else
        raise ArgumentError, "Valid options are: :project (receives an Hpricot Object) OR :project_id + :token"
      end
      build_project
    end

    # Builds an array containing the project's story
    def stories ; @stories || get_stories ; end

    # Fetches a story with given id
    def story(id)
      TrackR::Story.new(:story_id => id, :project_id => @id, :token => @token)
    end

    # Creates a story for this project. Receives a set of valid attributes.
    # Returns a TrackR::Story object
    # TODO: Validate attributes
    def create_story(attributes = {})
      api_url = URI.parse("#{CONFIG[:api_url]}projects/#{@id}/stories")
      query_string = attributes.map { |key, value| "story[#{key}]=#{CGI::escape(value)}"}.join('&')
      begin
        http = Net::HTTP.new(api_url.host, api_url.port)
        http.use_ssl = true
        response, data = http.post(api_url.path, query_string.concat("&token=#{@token}"))

        raise ResponseError, "Wrong response code" unless response.code.to_i == 200
        story = (Hpricot(response.body)/:story)
        TrackR::Story.new(:story => story, :project_id => @id, :token => @token)
      rescue ResponseError => e
        print "Got response code [#{response.code}]:\t"
        puts response.message
        raise
      end
    end

    # Deletes a story given a TrackR::Story object or a story_id
    def delete_story(story)
      if story.is_a?(TrackR::Story)
        api_url = URI.parse("#{CONFIG[:api_url]}projects/#{@id}/stories/#{story.id}")
      elsif story.is_a?(Integer) || story.to_i.is_a?(Integer)
        api_url = URI.parse("#{CONFIG[:api_url]}projects/#{@id}/stories/#{story}")
      else
        raise ArgumentError, "Should receive a story id or a TrackR::Story object."
      end
      begin
        http = Net::HTTP.new(api_url.host, api_url.port)
        http.use_ssl = true
        response, data = http.delete(api_url.path, {"X-TrackerToken" => @token})
        raise ResponseError, "Wrong response code" unless response.code.to_i == 200
        story = (Hpricot(response.body)/:story)
        TrackR::Story.new(:story => story, :project_id => @id, :token => @token)
      rescue ResponseError => e
        print "Got response code [#{response.code}]:\t"
        puts response.message
        raise
      end
    end

    # Gets the backlog's stories
    def backlog
      get_stories_by_iteration("backlog")
    end

    # Gets the current iteration's stories
    def current
      get_stories_by_iteration("current")
    end

    # Gets the icebox iteration's stories
    def icebox
      get_stories_by_iteration("icebox")
    end

    # Gets the done iteration's stories
    def done
      get_stories_by_iteration("done")
    end

    protected

    # Builds a project given an hpricot object stored at instance variable
    # @project
    def build_project
      @id               ||= @project.at('id').inner_html
      @api_url          ||= "#{CONFIG[:api_url]}projects/#{@id}"
      @url              ||= "http://www.pivotaltracker.com/projects/#{@id}"
      @name             = @project.at('name').inner_html
      @iteration_length = @project.at('iteration_length').inner_html
      @week_start_day   = @project.at('week_start_day').inner_html
      @point_scale      = @project.at('point_scale').inner_html.split(',')
    end

    # Builds an array containing the project's stories
    def get_stories
      api_url = "#{CONFIG[:api_url]}projects/#{@id}/stories"
      @stories = (Hpricot(open(api_url, {"X-TrackerToken" => @token.to_s}))/:story).map {|story| TrackR::Story.new(:story => story, :project_id => @id, :token => @token)}
    end

    # Builds an array containing the project's stories for a given iteration
    def get_stories_by_iteration(name)
      case name
      when "icebox"
        api_url = "#{CONFIG[:api_url]}projects/#{@id}/stories?filter=current_state%3Aunscheduled"
      else
        api_url = "#{CONFIG[:api_url]}projects/#{@id}/iterations/#{name}"
      end
      @stories = (Hpricot(open(api_url, {"X-TrackerToken" => @token.to_s}))/:story).map {|story| TrackR::Story.new(:story => story, :project_id => @id, :token => @token)}
    end

  end # class TrackR::Tracker::TrackR::Project

  class ResponseError < Exception ;end
end
