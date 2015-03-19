class CreateWhispers < ActiveRecord::Migration
  def change
    create_table :whispers do |t|
      t.text  :content
      t.belongs_to :user

      t.timestamps
    end
  end
end
