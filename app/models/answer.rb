class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  validates :body, :question, :user, presence: true
  validates :body, length: {minimum: 5, message: "is too short (minimum is 5 characters)" }
  validates :user, presence: true
end
