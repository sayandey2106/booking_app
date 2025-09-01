class CreateModels < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.timestamps
    end

    create_table :movies do |t|
      t.string :title, null: false
      t.integer :duration, null: false
      t.string :language, null: false
      t.timestamps
    end

    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.string :seat_number, null: false
      t.datetime :show_time, null: false
      t.timestamps
    end
  end
end
