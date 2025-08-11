class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.text :summary
      t.text :tags
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
