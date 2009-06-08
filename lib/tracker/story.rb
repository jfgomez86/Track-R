class Story
  attr_accessor :id, :story_type, :url, :estimate, :current_state,
    :description, :name, :requested_by, :owned_by, :created_at, :accepted_at,
    :labels
  def initialize
    #@id            = id
    #@story_type    = story_type
    #@url           = url
    #@estimate      = estimate
    #@current_state = current_state
    #@description   = description
    #@name          = name
    #@requested_by  = requested_by
    #@owned_by      = owned_by
    #@created_at    = created_at
    #@accepted_at   = accepted_at
    #@labels        = labels
    #<id type="integer">STORY_ID</id>
    #<story_type>feature</story_type>
    #<url>http://www.pivotaltracker.com/story/show/STORY_ID</url>
    #<estimate type="integer">1</estimate>
    #<current_state>accepted</current_state>
    #<description></description>
    #<name>More power to shields</name>
    #<requested_by>James Kirk</requested_by>
    #<owned_by>Montgomery Scott</owned_by>
    #<created_at type="datetime">2008/12/10 00:00:00 UTC</created_at>
    #<accepted_at type="datetime">2008/12/10 00:00:00 UTC</accepted_at>
    #<labels>label 1,label 2,label 3</labels>
  end

end # class Tracker::Story
