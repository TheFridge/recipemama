require 'test_helper'

class GetRequestTest < Minitest::Test

  def setup
    @getrecipe = GetRecipe.new
  end

  def test_contribution_link_formats_username
    VCR.use_cassette('toad-in-the-hole') do
      assert_equal "Cookie Cutter Toad-in-the-Hole", @getrecipe.get_response('Cookie-Cutter-Toad-in-the-Hole-496678')['name']
    end
  end

  # def test_render_ingredients
  #   VCR.use_cassette('toad-in-the-hole') do
  #     assert_equal "Cookie Cutter Toad-in-the-Hole", @getrecipe.get_response('Cookie-Cutter-Toad-in-the-Hole-496678')['id']
  #   end
  # end

end
