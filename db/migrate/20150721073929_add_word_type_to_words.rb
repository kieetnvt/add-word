class AddWordTypeToWords < ActiveRecord::Migration
  def change
    add_column :words, :word_type, :integer, default: 0
  end
end
