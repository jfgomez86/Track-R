module TrackR
  class Comment
    attr_accessor :id, :text, :author, :noted_at, :story_id, :project_id, :token

    def initialize(options = {})
      @token = options[:token].to_s
      @project_id = options[:project_id]
      @story_id = options[:story_id]
      @comment = Hpricot(options[:comment])
      build_comment
    end

    private

    def build_comment
      if @comment
        @id       = @comment.at('id').inner_html.chomp       unless @comment.at('id').nil?
        @text     = @comment.at('text').inner_html.chomp     unless @comment.at('text').nil?
        @author   = @comment.at('author').inner_html.chomp   unless @comment.at('author').nil?
        @noted_at = @comment.at('noted_at').inner_html.chomp unless @comment.at('noted_at').nil?
      end
    end
  end
end
