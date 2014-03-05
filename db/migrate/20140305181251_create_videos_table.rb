class CreateVideosTable < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :file
      t.string :screenshot
      t.string :filename
      t.timestamps
    end
  end

  def down
    drop_table :videos
  end
end
