require 'rails_helper'

describe Task do

  describe 'associations' do
    it { should belong_to(:column) }
  end
end
