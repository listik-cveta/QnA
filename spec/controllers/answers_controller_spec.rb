require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 2, question: question) }


  describe 'POST #create' do
    before { sign_in(user) }
    context 'with valid attributes' do

      it 'added new answer to his question' do
        expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(question.answers, :count).by(1)
      end

      it 'added new answer to his question by user' do
        expect { post :create, answer: attributes_for(:answer), question_id: question }.to change(user.answers, :count).by(1)
      end


      it "render questions path template" do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to(question_path(assigns(:question)))
      end


    end
    context "with invalid attributes" do
      it "added the new answer with invalid attributes" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.not_to change(Answer, :count)
      end
      it "redirect to the show view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to redirect_to(question_path(assigns(:question)))
      end

    end
  end

  describe '#DELETE #destroy' do

    it 'deletes by answer\'s owner' do
      sign_in(user)
      answer
      expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
    end

    it 'deletes answer by another user' do
      sign_in(user1)
      answer
      expect { delete :destroy, id: answer }.not_to change(Answer, :count)
    end

  end
end
