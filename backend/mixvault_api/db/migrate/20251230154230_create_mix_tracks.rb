class CreateMixTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :mix_tracks do |t|
      t.references :mix, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.integer :position, null: false
      t.integer :start_seconds, null: false

      t.timestamps
    end

    add_index :mix_tracks, [ :mix_id, :track_id ], unique: true
  end
end
