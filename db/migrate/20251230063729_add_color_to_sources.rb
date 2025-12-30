class AddColorToSources < ActiveRecord::Migration[8.1]
  def change
    add_column :sources, :color, :string, default: "blue"
  end
end
