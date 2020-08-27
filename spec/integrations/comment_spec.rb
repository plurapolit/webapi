# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment' do
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let(:panel) { create :panel, category: category }
  let(:user) { create :user }
  let(:statement) { create :statement, user: user, panel: panel }
  let(:commentator) { create :user, email: 'sec@email.com' }
  let(:the_comment_statement) { create :statement, user: commentator, panel: panel }
  let(:comment) { create :comment, recipient: statement, sender: the_comment_statement }

  it 'is a statement' do
    expect(comment.recipient).to be_a(Statement)
  end

  it 'is an answer to a statement ' do
    expect(comment.sender).to be_a(Statement)
  end
end
