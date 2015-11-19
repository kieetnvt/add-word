class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.timestamps null: false
      t.string :title, null: false
      t.string :content, null: false
      t.integer :user_id, null: false
    end
  end
end
