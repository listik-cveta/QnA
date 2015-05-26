require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:answers) { create_list(:answer, 2, question: question) }


  describe 'POST #create' do
    before { sign_in(user) }
    context 'with valid attributes' do

      it 'added new answer to his question' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)

      end

      it 'added new answer to his question by user' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(user.answers, :count).by(1)
      end


      it "renders answer show view" do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to have_content @answer
      end


    end
    context "with invalid attributes" do
      it "added the new answer with invalid attributes" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.not_to change(Answer, :count)
      end
      # it "redirect to the show view" do
      #   post :create, answer: attributes_for(:invalid_answer), question_id: question
      #   #expect(response).to redirect_to(question_path(question))
      # end

    end
  end

  describe '#DELETE #destroy' do

    it 'deletes by answer\'s owner' do
      sign_in(user)
      answer
      expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1), format: :js
    end

    it 'deletes answer by another user' do
      sign_in(user1)
      answer
      expect { delete :destroy, id: answer }.not_to change(Answer, :count)
    end

  end

  describe 'PATCH #update' do
      before { sign_in(user) }
      it 'assings the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq(answer)
    end

    it 'assigns th question' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: question, answer: { body: 'new body'}, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
    end
end