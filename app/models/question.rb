class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  #has_many :votes, as: :votable, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true, length: {minimum: 5, message: "is too short (minimum is 5 characters)"}
  validates :title, length: { maximum: 70, message: "is too long (maximum is 70 characters)" }
  validates :user, presence: true

  def vote_up
    votes.create('1')
  end

  def vote_down
  end

  def unvote
  end


 end
