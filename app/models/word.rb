class Word < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  enum word_type: [:note, :translate]

  def self.newest
    order(created_at: :desc)
  end

  def self.search(title = "")
    wildcard_search = "%#{title}%"
    where("title LIKE :search", search: wildcard_search)
  end

  paginates_per 20
end