class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_answer, only: [:edit, :update, :destroy, :make_best]
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
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end


  def destroy
    @answer.destroy
  end

  def make_best
      @question = @answer.question
    if current_user.id == @question.user_id
      @answer.best_answer
    else
      render status: :forbidden
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