configure :production, :development, :test do
  env = ENV['RACK_ENV'] || "development"

  db_settings = YAML::load(ERB.new(File.open("config/database.yml"))).result[env]
  
  ActiveRecord::Base.establish_connection(
      :adapter  => db_settings["adapter"],
      :host     => db_settings["host"],
      :username => db_settings["username"],
      :password => db_settings["password"],
      :database => db_settings["database"],
      :encoding => 'utf8'
  )
end
