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

    context 'valid url' do
      it "returns a success response" do
        get :show, params: { title: board.title }
        expect(response).to be_successful
      end
    end

    context 'invalid url' do
      it "returns a 404 response" do
        get :show, params: { title: '123123' }
        expect(response).to be_not_found
      end
    end
  end
end
