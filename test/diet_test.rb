require 'test_helper'

class DietTest < Minitest::Test
  def setup
    DatabaseCleaner.start
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
    DatabaseCleaner.clean
  end
end
