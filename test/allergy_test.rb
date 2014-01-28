require 'test_helper'

class AllergyTest < Minitest::Test

  def setup
    @allergy = Allergy.new
  end

  def test_create_yummly_code_formats_correctly
    @allergy.yummly_id = "393"
    @allergy.name = "Gluten-Free"
    @allergy.save
    assert_equal nil, @allergy.yummly_code
    @allergy.create_yummly_code
    assert_equal "393^Gluten-Free", @allergy.yummly_code
  end

  def test_generate_allergies
    VCR.use_cassette('allergies') do
      assert_equal "boo", Allergy.generate_allergies
    end
  end

end