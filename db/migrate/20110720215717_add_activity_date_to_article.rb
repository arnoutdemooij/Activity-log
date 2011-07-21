class AddActivityDateToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :activity_date, :date
  end

  def self.down
    remove_column :articles, :activity_date
  end
end
