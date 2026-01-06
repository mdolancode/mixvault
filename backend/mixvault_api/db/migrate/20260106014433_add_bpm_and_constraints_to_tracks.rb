class AddBpmAndConstraintsToTracks < ActiveRecord::Migration[8.1]
  def change
    add_column :tracks, :bpm, :integer

    # If you already have rows, you must backfill before setting NOT NULL.
    # For a fresh DB you can skip the backfill, but this is safe:
    reversible do |dir|
      dir.up do
        execute "UPDATE tracks SET title = 'Unknown Title' WHERE title IS NULL"
        execute "UPDATE tracks SET artist = 'Unknown Artist' WHERE artist IS NULL"
        execute "UPDATE tracks SET bpm = 120 WHERE bpm IS NULL"
      end
    end

    change_column_null :tracks, :title, false
    change_column_null :tracks, :artist, false
    change_column_null :tracks, :bpm, false
  end
end