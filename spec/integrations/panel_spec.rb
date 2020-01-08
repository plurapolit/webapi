# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Panel' do
  let(:category) { create :category }
  let(:panel) { create :panel, category: category }

  it 'has a title' do
    expect(panel.title).to eq('Test Panel')
  end

  it 'has a short title' do
    expect(panel.short_title).to eq('Kurz Title Panel')
  end

  it 'has a description' do
    expect(panel.description).to eq('Das hier ist eine Beschreibung')
  end

  it 'is associated with a category' do
    expect(panel.category).to eq(category)
  end

  context 'when created' do
    it 'has to have a title' do
      panel.title = ''
      panel_without_title = panel.save
      expect(panel_without_title).to eq(false)
    end

    it 'has to have a short title' do
      panel.short_title = ''
      panel_without_short_title = panel.save
      expect(panel_without_short_title).to eq(false)
    end

    it 'has to have a description' do
      panel.description = ''
      panel_without_description = panel.save
      expect(panel_without_description).to eq(false)
    end

    it 'has to be associated with a category' do
      panel.category = nil
      panel_without_category = panel.save
      expect(panel_without_category).to eq(false)
    end
  end
end
