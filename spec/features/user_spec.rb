# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Features', type: :feature do
  let!(:organisation) { create :organisation }
  before do
    sign_in_admin
  end

  describe 'default User' do
    before do
      create(:user)
      visit '/users'
    end

    context 'when visiting the index page' do
      it 'shows all users' do
        create(:user, first_name: 'Second User', email: 'second@mail.com')
        visit '/users'
        expect(page).to have_content('Bat').and have_content('Second User')
      end
    end

    it 'can be edited' do
      click_on 'Edit'
      fill_in 'user_first_name', with: 'New user edited'
      click_on 'Update User'
      expect(page).to have_content('User was successfully updated')
    end

    it 'can be deleted', js: true do
      accept_confirm do
        click_on 'Delete'
      end
      expect(page).to have_content('User was successfully destroyed')
    end

    context 'when creating' do
      before do
        click_on 'New'
        fill_in 'user_first_name', with: 'New first name'
        fill_in 'user_last_name', with: 'New last name'
        select organisation.name, from: 'user_organisation_id'
        select :default, from: 'user_role'
        fill_in 'user_email', with: 'email@email.com'
      end

      describe 'a default user' do
        it 'successfully does create' do
          click_on 'Create User'
          expect(page).to have_content('User was successfully created')
        end
      end

      describe 'an admin user' do
        it 'successfully does create' do
          select :expert, from: 'user_role'
          click_on 'Create User'
          expect(page).to have_content('User was successfully created')
        end
      end

      context 'when uploading an attachment' do
        it 'allows pngs' do
          attach_file('user_avatar', file_fixture('sample.png'))
          click_on 'Create User'
          expect(page).to have_content('User was successfully created')
        end

        it 'allows jpgs' do
          attach_file('user_avatar', file_fixture('sample.jpg'))
          click_on 'Create User'
          expect(page).to have_content('User was successfully created')
        end

        it 'does not allow other filetypes (.txt)' do
          attach_file('user_avatar', file_fixture('sample.txt'))
          click_on 'Create User'
          expect(page).to have_content('Avatar is not a valid image type')
        end
      end
    end
  end
end
