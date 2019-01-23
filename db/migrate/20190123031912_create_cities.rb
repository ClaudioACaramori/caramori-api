class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :code
      t.integer :state_code, index: true

      t.timestamps
    end
  end
end
