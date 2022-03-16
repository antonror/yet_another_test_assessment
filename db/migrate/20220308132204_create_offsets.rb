class CreateOffsets < ActiveRecord::Migration[7.0]
  def change
    create_table :offsets do |t|
      t.decimal :value, precision: 2, scale: 1
    end
  end
end
