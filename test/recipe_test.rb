require 'test_helper'

class RecipeTest < Minitest::Unit::TestCase

  def setup
    @recipe = Recipe.new
    Key.create(application_id: ENV['YUMMLY_ID'], application_keys: ENV['YUMMLY_KEY'])
  end

  #def test_contribution_link_formats_username
    #VCR.use_cassette('toad-in-the-hole') do
      #assert_equal "Cookie Cutter Toad-in-the-Hole", @getrecipe.get_response('Cookie-Cutter-Toad-in-the-Hole-496678')['name']
   # end
  #end
end
