class AddVisibleToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :visible, :string
  end
end
