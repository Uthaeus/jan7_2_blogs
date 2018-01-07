require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    before do
      visit blogs_path
    end
    it 'can be reached successfully' do
      expect(page.status_code).to eq (200)
    end

    it 'has a title of Blogs' do
      expect(page).to have_content(/Blogs/)
    end
  end
end