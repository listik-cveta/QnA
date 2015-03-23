class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  validates :title, :body, presence: true, length: {minimum: 10, message: "is too short (minimum is 10 characters)"}
  validates :title, length: { maximum: 70, message: "is too long (maximum is 70 characters)" }
end
