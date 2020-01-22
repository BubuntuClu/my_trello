class AddColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :columns do |t|
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
