require 'rails_helper'

RSpec.describe BoardsController do

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do

    let!(:board) { Board.create(title: 'test') }

    it "returns a success response" do
      get :show, params: { title: board.title }
      expect(response).to be_successful
    end
  end
end
