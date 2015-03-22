class AddRiskToPage < ActiveRecord::Migration
  def change
    add_column :pages, :risk, :integer
  end
end
