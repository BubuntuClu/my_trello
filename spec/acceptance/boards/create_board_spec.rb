require 'rails_helper'

feature 'create boards'do

  scenario 'user creates board' do
    visit root_path
    expect(page).to have_content 'Создать доску'
    click_on 'Создать доску'
    expect(current_path).to eq board_path(Board.last.title)
    expect(page).to have_content 'Добавить колонку'
  end
end
