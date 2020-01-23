require 'rails_helper'

feature 'show created board'do

  scenario 'user can see created board' do
    board = Board.create(title: 'spec')
    visit root_path
    expect(page).to have_content "Доска #{board.title}"
    click_on "Доска #{board.title}"

    expect(current_path).to eq board_path(board.title)
    expect(page).to have_content 'Добавить колонку'
  end
end
