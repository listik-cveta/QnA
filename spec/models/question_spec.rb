require 'rails_helper'

RSpec.describe Question, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of :title}
  it { should validate_presence_of :body}
  it { should validate_length_of(:body).is_at_least(5) }
  it { should validate_length_of(:title).is_at_most(70) }
  it { should validate_presence_of :user}

  
end
