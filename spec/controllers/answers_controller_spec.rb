require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  let(:questions) { Question.all }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'added new answer to his question' do
        expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(question.answers, :count).by(1)
      end

      it "render questions path template" do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to(question_path(assigns(:question)))
      end

    end
    context "with invalid attributes" do
      it "added the new answer with invalid attributes" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.to_not change(Answer, :count)
      end
      it "redirect to the show view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to redirect_to(question_path(assigns(:question)))
      end

    end
  end
end
