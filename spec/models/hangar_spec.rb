require 'rails_helper'

RSpec.describe Hangar, type: :model do
  it { should have_many(:products) }
  it { should validate_presence_of :number }
end