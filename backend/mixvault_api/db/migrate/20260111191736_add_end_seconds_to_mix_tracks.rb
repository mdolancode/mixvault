class AddEndSecondsToMixTracks < ActiveRecord::Migration[8.1]
  def change
    add_column :mix_tracks, :end_seconds, :integer
    add_index :mix_tracks, [ :mix_id, :position ], unique: true

    # Optional but recommended once data is clean:
    # change_column_null :mix_tracks, :end_seconds, false
  end
end
