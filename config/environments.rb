configure :development, :test do
  env = ENV['RACK_ENV'] || "development"

  db_settings = YAML.load(ERB.new(File.read(File.join("config", "database.yml"))).result)[env]
  
  ActiveRecord::Base.establish_connection(
      :adapter  => db_settings["adapter"],
      :host     => db_settings["host"],
      :username => db_settings["username"],
      :password => db_settings["password"],
      :database => db_settings["database"],
      :encoding => 'utf8'
  )
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/recipe_development')
  
  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end
