class AddRecordedAtToMixes < ActiveRecord::Migration[8.1]
  def change
    add_column :mixes, :recorded_at, :datetime
  end
end
