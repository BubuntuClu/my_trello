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

      click_on 'Редактировать'
    end

    within '#edit_task_modal' do
      fill_in 'edit_task_title', with: 'new value'
      click_on 'Редактировать карточку'
    end

    within '.task_area' do
      expect(page).to have_content "new value"
      expect(page).not_to have_content "for_delete"
    end
  end
end
