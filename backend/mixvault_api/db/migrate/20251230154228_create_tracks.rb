class CreateTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.references :label, null: false, foreign_key: true
      t.boolean :pool_eligible
      t.string :isrc

      t.timestamps
    end
  end
end
