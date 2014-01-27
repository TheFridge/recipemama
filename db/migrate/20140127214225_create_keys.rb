class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :application_id
      t.string :application_keys
    end
  end
end
