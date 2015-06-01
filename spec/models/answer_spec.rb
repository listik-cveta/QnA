require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should validate_length_of(:body).is_at_least(5) }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }

  describe '#best' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question) }
    let!(:previous_best_answer) { create(:answer, question: question, best: true) }
    before { answer.best_answer }

    it 'only question user can mark answer as best' do
      expect(answer.best_answer.user_id).to eq question.user_id
    end

    # it 'should change answer to best' do
    #   expect(answer.best_answer).to eq true
    # end
    #
    # it 'previous best answer should not to be best' do
    #   expect(previous_best_answer).to_not eq true
    # end
    #
    #
    # it 'should "best" only one answer' do
    #   expect(question.answers.where(best: true).count).to eq 1
    # end


  end


end
