class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :person_1_id
      t.integer :person_2_id

      t.timestamps
    end
  end
end
