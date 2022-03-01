class ChangeUpctype < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :upc, :string
  end
end
