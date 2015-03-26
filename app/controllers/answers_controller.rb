class AnswersController < ApplicationController
  #before_action :load_answer, only: [:create]
  # def index
  #   @answer = Answer.all
  # end

  # def show
  # end

#   def create
#     @question = Question.find(params[:id])
#     @answer = Answer.new
#
#   end
#
# private
#
#  def load_answer
#    @answer = Answer.find(params[:question_id])
#  end
#
#   def answer_params
#     params.require(:answer).permit(:body)
#   end

  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    redirect_to question_path(@question)
  end

  #private
  def answer_params
    params.require(:answer).permit(:body, :ques)
  end

end
