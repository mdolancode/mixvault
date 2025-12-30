class CreateMixes < ActiveRecord::Migration[8.1]
  def change
    create_table :mixes do |t|
      t.string :title
      t.string :dj_name
      t.integer :duration_seconds
      t.string :audio_url
      t.integer :status

      t.timestamps
    end
  end
end
