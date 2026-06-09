class AddSeriesAndContentToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :series, null: true, foreign_key: true
    add_column :posts, :position, :integer
    add_column :posts, :content_path, :string
  end
end
