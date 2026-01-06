class AddDurationSecondsToTracks < ActiveRecord::Migration[8.1]
  def change
    add_column :tracks, :duration_seconds, :integer, null: false, default: 0
  end
end