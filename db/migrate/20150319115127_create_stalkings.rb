class CreateStalkings < ActiveRecord::Migration
  def change
    create_table :stalkings do |t|
      t.integer :stalker_id
      t.integer :stalkee_id

      t.timestamps
    end
  end
end
