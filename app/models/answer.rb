class Answer < ActiveRecord::Base
  belongs_to :question
  validates :body, presence: true
  validates :body, length: {minimum: 10, message: "is too short (minimum is 10 characters)" }
end
