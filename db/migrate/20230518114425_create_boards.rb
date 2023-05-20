# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :email
      t.integer :width
      t.integer :height
      t.integer :mines
      t.string :matrix, type: :array
      t.timestamps
    end

    add_index :boards, :name, unique: true
  end
end
