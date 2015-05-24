require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should validate_length_of(:body).is_at_least(5) }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }

  describe '#best' do
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question) }
    let!(:old_best_answer) { create(:answer, question: question, best: true) }
    before { answer.best }


    it 'should change answer to best' do
      expect(answer.best?).to eq true
    end

    it 'should "best" only one answer' do
      expect(question.answers.where(best: true).count).to eq 1
    end


  end


end
