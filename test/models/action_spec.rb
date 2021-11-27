# frozen_string_literal: true

require 'test_helper'

RSpec.describe Auction, type: :model do
  it { should validate_presence_of(:goal) }
end
