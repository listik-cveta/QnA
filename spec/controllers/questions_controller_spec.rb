require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:question) {create(:question, user: user)}

  describe 'GET #index' do

    let(:questions) { create_list(:question, 2) }
    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end

    describe 'GET #new' do
      before {sign_in(user) }
      before { get :new }

      it 'assigns a new Question to Question' do
        expect(assigns(:question)).to be_a_new(Question)
      end
      it 'render new view' do
        expect(response).to render_template :new
      end
    end

  end

  describe 'POST #create' do
    before {sign_in(user) }

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question)}.to change(Question, :count).by(1)
      end

      it 'saves the new question in the database by user' do
        expect { post :create, question: attributes_for(:question)}.to change(user.questions, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end
      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }
    it 'deletes question' do
    sign_in(user)
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'deletes question by another user' do
      sign_in(user1)
      expect {delete :destroy, id: question}.not_to change(Question, :count)

    end
    it 'redirect to index view' do
      sign_in(user)
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end