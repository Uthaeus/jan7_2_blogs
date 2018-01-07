require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'Creation' do
    before do
      @blog = Blog.create(title: "A title", date: Date.today, body: "Something here")
    end
    it 'can be created' do
      expect(@blog).to be_valid
    end

    it 'cannot be created without a title, date, and body' do
      @blog.title = nil
      @blog.date = nil
      @blog.body = nil
      expect(@blog).to_not be_valid
    end
  end
end
