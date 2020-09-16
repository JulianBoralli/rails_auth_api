require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  describe 'attributes' do
    subject { user }

    it { should respond_to(:username) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:auth_token) }
  end

  describe 'validations' do
    subject { user }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('foo@valid.email.com').for(:email) }
    it { should_not allow_value('foofakeemail.@com').for(:email) }
  end

end
