require 'rails_helper'

describe Column do

  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should belong_to(:board) }
  end
end
