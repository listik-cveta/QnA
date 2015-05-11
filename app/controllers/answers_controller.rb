class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_answer, only: [:edit, :update, :destroy]
  before_action :authors_only, only: [:edit, :update, :destroy]

  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Answer successfully added'
    else
      flash[:alert] = 'Something wrong'
      redirect_to question_path(@question)
    end
  end

  def update

  end


  def destroy
    if @answer.destroy
      flash[:notice] = 'Your answer has deleted'
      redirect_to question_path(@answer.question)
    else
      flash[:alert] = 'You have not access to delete foreign answer '
    end

  end

  private


  def load_answer
    @answer = Answer.find(params[:id])
  end

  def authors_only
    if @answer.user_id != current_user.id
      redirect_to @answer, alert: 'answer.failure.not_an_author'
    end
  end


  def answer_params
    params.require(:answer).permit(:body)
  end
end