class CreateTemperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :temperatures do |t|
      t.decimal :value, precision: 3, scale: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
