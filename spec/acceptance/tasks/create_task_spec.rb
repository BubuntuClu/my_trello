require 'rails_helper'

feature 'create task' do
  given(:board) { Board.create(title: 'spec_column') }
  given!(:column) { board.columns.create }

  scenario 'user creates columns', js: true do
    visit board_path(board.title)
    within '#column_area' do
      click_on 'Добавить карточку'
    end

    within '#create_task_modal' do
      fill_in 'create_task_title', with: 'Test task'
      click_on 'Создать карточку'
    end

    within '.task_area' do
      expect(page).to have_content "X"
      expect(page).to have_content "Редактировать"
      expect(page).to have_content "Test task"
    end
  end
end
