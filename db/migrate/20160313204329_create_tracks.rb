class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :author
      t.string :album
      t.string :gener
      t.string :url
      t.references :playlist, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
