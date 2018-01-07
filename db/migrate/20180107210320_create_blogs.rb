class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.date :date
      t.text :body

      t.timestamps
    end
  end
end
