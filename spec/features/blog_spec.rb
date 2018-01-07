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

  describe 'creation' do
    before do
      visit new_blog_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'blog[title]', with: "A title"
      fill_in 'blog[date]', with: Date.today
      fill_in 'blog[body]', with: "Something here"
      click_on "Save"

      expect(page).to have_content("Something here") 
    end
  end
end