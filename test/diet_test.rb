require_relative './test_helper'

class DietTest < Minitest::Unit::TestCase
  def setup
    Diet.destroy_all
    @diet = Diet.new
  end

  def test_generate_diets
    VCR.use_cassette('diets') do
      Key.create(application_id: ENV['YUMMLY_ID'], application_keys: ENV['YUMMLY_KEY'])
      Diet.generate_diets
      assert_equal 5, Diet.all.count
      assert_equal "Pescetarian", Diet.first.name
    end
  end

  def teardown
    Diet.destroy_all
  end
end
