class AddDescs < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :title

      t.timestamps
    end

    add_index :boards, :title, unique: true
  end
end
