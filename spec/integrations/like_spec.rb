# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Like' do
  let(:category) { create :category }
  let(:panel) { create :panel, category: category }
  let(:user) { create :user }
  let(:statement) { create :statement, user: user, panel: panel }
  let(:sec_user) { create :user, email: 'sec@email.com' }

  describe 'a statement' do
    it 'can be liked' do
      create(:like, statement: statement, user: user)
      expect(statement.likes.count).to eq(1)
    end

    it 'can be liked multiple times' do
      create(:like, statement: statement, user: user)
      create(:like, statement: statement, user: sec_user)
      expect(statement.likes.count).to eq(2)
    end
  end
end
