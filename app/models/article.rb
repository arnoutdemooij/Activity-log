class Article < ActiveRecord::Base
  # Relations
  belongs_to :user

  attr_accessor :generate_tweet

  validates_uniqueness_of :activity_date, :scope => :user_id
end
