require 'rails_helper'

describe 'navigate' do
  before do
    user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Jim", last_name: "Beam")
    login_as(user, :scope => :user)
  end
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

    it 'has a list of blogs' do
      blog1 = Blog.create(title: "Blog1", date: Date.today, body: "Something here")
      blog2 = Blog.create(title: "Blog2", date: Date.today, body: "Something else here")
      visit blogs_path

      expect(page).to have_content(/Blog1|Blog2/)
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

    it 'will have a user associated with it' do
      fill_in 'blog[title]', with: "A title"
      fill_in 'blog[date]', with: Date.today
      fill_in 'blog[body]', with: "Whatever here"
      click_on "Save"

      expect(User.last.blogs.last.body).to eq("Whatever here")
    end
  end
end