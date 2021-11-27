# frozen_string_literal: true

# Module class to validate action plan body parameters
class Action < ApplicationRecord
  validates :goal, presence: true
  validates :created_on, presence: true
  validate :deadline
  validates :is_completed, inclusion: { in: [true, false] }
  validate :completed_on
end
