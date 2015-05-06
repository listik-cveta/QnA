class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authors_only, only: [:edit, :update, :destroy]
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  # def update
  #   if @question.update(question_params)
  #     redirect_to @question
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def authors_only
    if @question.user_id != current_user.id
      redirect_to @question, alert:'question.failure.not_an_author'
    end
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id )
  end
end