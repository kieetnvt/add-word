class ChangeContentTypeWords < ActiveRecord::Migration
  def change
    change_column :words, :content, :text
  end
end
