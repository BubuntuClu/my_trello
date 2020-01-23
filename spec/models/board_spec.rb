require 'rails_helper'

describe Board do

  describe 'associations' do
    it { should have_many(:columns).dependent(:destroy) }
  end
end
