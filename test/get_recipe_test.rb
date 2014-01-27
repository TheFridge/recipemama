require 'test_helper'

class GetRequestTest < Minitest::Test

  def setup
    @getrecipe = GetRecipe.new
  end

  def test_contribution_link_formats_username
    assert_equal "boo", @getrecipe.get_url(1)
  end

end
