# Production

###Visit Recipe Mama at:
###http://recipemama.herokuapp.com/

Visiting the home page will give you a random dinner recipe rendered in JSON from the Yummly API

![alt text](https://github.com/TheFridge/recipemama/blob/master/presentation/JSON_i1.png?raw=true, "JSON1")

--
# Database

###RecipeMama uses Sinatra Active Record

#####Due to quirks in the Sinatra Active Record System - you will need to run both

```sh
rake db:migrate
```
```sh
RACK_ENV=test rake db:migrate
```

#####Rake tasks that are allowed with Sinatra Active Record are:

```sh
$ rake -T
rake db:create_migration  # create an ActiveRecord migration
rake db:migrate           # migrate the database (use version with VERSION=n)
rake db:rollback          # roll back the migration (use steps with STEP=n)
rake db:schema:dump       # dump schema into file
rake db:schema:load       # load schema into database
rake db:seed              # Generate a seeds.rb file to seed
```

#####In order to access the Yummly API - you will need to get a API ID and Key from Yummly
Save the API ID and Key in your .bash_profile as:

```sh
export YUMMLY_ID=YOUR ID
export YUMMLY_KEY=YOUR KEY
```

Additionally, you will need to manually add the Key to your database

```sh
irb
load 'app.rb'
Key.create(application_id: "YOUR ID", application_keys: "YOUR KEY")
```

### Creating a Migration

You can create a migration:

```sh
$ rake db:create_migration NAME=create_users
```

This will create a migration file in your migrations directory (`./db/migrate`
by default), ready for editing.

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end
```

--
# Testing

***Running the tests requires having the Yummly API key and id in your .bash_profile (see above)***

Testing is done with MiniTest 

To run the suite:

```sh
rake test
```
