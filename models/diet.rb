class Diet < ActiveRecord::Base

  def self.get_url
    "http://api.yummly.com/v1/api/metadata/diet?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}"
  end

  def self.get_response
    response = Faraday.get(get_url)
    body = response.body.gsub("set_metadata('diet',", "")
    body = body.gsub(");", "")
    JSON.parse(body, :quirks_mode => true).first.last
  end

  def self.generate_diets
    get_response.each do |diet|
      new_diet = Diet.new
      new_diet.yummly_id = diet["id"]
      new_diet.name = diet["longDescription"]
      new_diet.yummly_code = diet["searchValue"]
      new_diet.save
    end
  end

end
