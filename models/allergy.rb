class Allergy < ActiveRecord::Base

  def create_yummly_code
    code = self.yummly_id.to_s + "^" + self.name
    self.yummly_code = code
    self.save
    code
  end

  def self.get_url
    "http://api.yummly.com/v1/api/metadata/allergy?_app_id=#{Key.first.application_id}&_app_key=#{Key.first.application_keys}"
  end

  def self.get_response
    response = Faraday.get(get_url)
    body = response.body.gsub("set_metadata('allergy',", "")
    body = body.gsub(");", "")
    JSON.parse(body, :quirks_mode => true).first.last
  end

  def self.generate_allergies
    get_response.each do |allergy|
      new_allergy = Allergy.new
      new_allergy.yummly_id = allergy["id"]
      new_allergy.name = allergy["shortDescription"]
      new_allergy.yummly_code = allergy["searchValue"]
      new_allergy.save
    end
  end
end
