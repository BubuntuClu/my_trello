require 'rails_helper'

feature 'create columns' do
  given(:board) { Board.create(title: 'spec_column') }
  given!(:column) { board.columns.create }

  scenario 'user creates columns', js: true do
    visit board_path(board.title)
    within '#column_area' do
      expect(page).to have_content 'Добавить карточку'
      expect(page).to have_content 'Удалить колонку'
      click_on 'Удалить колонку'

      expect(page).not_to have_content 'Добавить карточку'
      expect(page).not_to have_content 'Удалить колонку'
    end
  end
end
