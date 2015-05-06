require 'rails_helper'

RSpec.describe Answer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
    it { should validate_presence_of :body }
    it { should belong_to :question }
    it { should validate_length_of(:body).is_at_least(5) }
    it { should validate_presence_of :user }
    it { should validate_presence_of :question}
end
