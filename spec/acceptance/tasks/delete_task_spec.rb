require 'rails_helper'

feature 'delete task' do
  given(:board) { Board.create(title: 'spec_column') }
  given(:column) { board.columns.create }
  given!(:task) { column.tasks.create(title: 'for_delete') }

  scenario 'user creates columns', js: true do
    visit board_path(board.title)

    within '.task_area' do
      expect(page).to have_content "X"
      expect(page).to have_content "Редактировать"
      expect(page).to have_content "for_delete"

      click_on 'X'

      expect(page).not_to have_content 'Редактировать'
      expect(page).not_to have_content "Test task"
    end
  end
end
