class CreateTemperatures < ActiveRecord::Migration[7.1]
  def change
    create_table :temperatures do |t|
      t.float :temperature, null: false
      t.integer :epoch_time, null: false
      t.boolean :current, null: false, default: :true

      t.timestamps
    end
  end
end
