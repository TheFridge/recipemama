# Testing

```sh
Testing: RACK_ENV=test rake test
```

# Database

RecipeMama uses Sinatra Active Record - rake tasks that are allowed are:

```sh
$ rake -T
rake db:create_migration  # create an ActiveRecord migration
rake db:migrate           # migrate the database (use version with VERSION=n)
rake db:rollback          # roll back the migration (use steps with STEP=n)
rake db:schema:dump       # dump schema into file
rake db:schema:load       # load schema into database
rake db:seed              # Load your yummly access key information into the seed file
```

## Usage

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

Now migrate the database:

```sh
$ rake db:migrate
``