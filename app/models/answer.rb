class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  #has_many :votes, as: :votable, dependent: :destroy
  validates :body, :question, :user, presence: true
  validates :body, length: {minimum: 5, message: "is too short (minimum is 5 characters)"}
  validates :user, presence: true

  def best_answer
    Answer.transaction do
      self.question.answers.update_all(best: false)
      self.update(best: true)
    end
  end
end
