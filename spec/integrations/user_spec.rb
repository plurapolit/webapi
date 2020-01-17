# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User' do
  let(:organisation) { create :organisation }
  let(:user) { create :user, organisation: organisation }
  let(:expert) { create :expert, organisation: organisation }

  describe 'default User' do
    it 'has a first name' do
      expect(user.first_name).to eq('Bat')
    end

    it 'has a last name' do
      expect(user.last_name).to eq('Man')
    end

    it 'has an email' do
      expect(user.email).to eq('test@email.com')
    end

    it 'is associated with an organisation' do
      expect(user.organisation).to eq(organisation)
    end

    context 'when created' do
      it 'has to have a first_name' do
        user.first_name = ''
        user_without_first_name = user.save
        expect(user_without_first_name).to eq(false)
      end

      it 'has to have a last_name' do
        user.last_name = ''
        user_without_last_name = user.save
        expect(user_without_last_name).to eq(false)
      end

      it 'has to have an email' do
        user.email = ''
        user_without_email = user.save
        expect(user_without_email).to eq(false)
      end

      it 'does not have to be associated with an organisation' do
        user_without_org = build(:user, organisation: nil)
        expect(user_without_org.save).to eq(true)
      end
    end
  end

  describe 'expert User' do
    it 'has a first name' do
      expect(expert.first_name).to eq('The')
    end

    it 'has a last name' do
      expect(expert.last_name).to eq('One')
    end

    it 'has an email' do
      expect(expert.email).to eq('expert@email.com')
    end

    it 'is associated with an organisation' do
      expect(expert.organisation).to eq(organisation)
    end

    context 'when created' do
      it 'has to have a first_name' do
        expert.first_name = ''
        expert_without_first_name = expert.save
        expect(expert_without_first_name).to eq(false)
      end

      it 'has to have a last_name' do
        expert.last_name = ''
        expert_without_last_name = expert.save
        expect(expert_without_last_name).to eq(false)
      end

      it 'has to have an email' do
        expert.email = ''
        expert_without_email = expert.save
        expect(expert_without_email).to eq(false)
      end

      it 'has to be associated with an organisation' do
        expert.organisation = nil
        expert_without_organisation = expert.save
        expect(expert_without_organisation).to eq(false)
      end
    end
  end
end
