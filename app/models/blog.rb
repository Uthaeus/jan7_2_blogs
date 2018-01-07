class Blog < ApplicationRecord
  validates_presence_of :title, :date, :body
end
