# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action, type: :model do
  it { is_expected.to validate_presence_of(:goal) }
  it { is_expected.to validate_presence_of(:created_on) }
  it { should allow_value(%w[true false]).for(:is_completed) }
end
