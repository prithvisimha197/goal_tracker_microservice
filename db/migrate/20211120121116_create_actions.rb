# frozen_string_literal: true

# Method to create database schema for actions table
class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.text :goal
      t.datetime :created_on
      t.datetime :deadline
      t.boolean :is_completed
      t.datetime :completed_on

      t.timestamps
    end
  end
end
