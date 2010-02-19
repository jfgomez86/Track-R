require File.dirname(__FILE__) + '/../test_helper'

class TestTokenTest < Test::Unit::TestCase
  context "with a valid username and password" do

    setup do
      def token_options
        {:username => $config[:username], :password => $config[:password]}
      end
    end

    should "return a valid token" do
      @token = TrackR::Token.new(token_options)
      assert_equal $config[:token], @token.to_s
    end

  end
end
