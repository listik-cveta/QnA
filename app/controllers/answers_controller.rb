class AnswersController < ApplicationController


  def new
  end

  def create
    @question = Question.find(params[:question_id])
    if @answer = @question.answers.create(answer_params)
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def answer_params
    params.require(:answer).permit(:body, :question)
  end

end