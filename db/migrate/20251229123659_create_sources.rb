class CreateSources < ActiveRecord::Migration[8.1]
  def change
    create_table :sources do |t|
      t.string :name, null: false
      t.uuid :token, null: false, default: "gen_random_uuid()"

      t.timestamps
    end

    add_index :sources, :token, unique: true

    add_reference :ses_messages, :source, foreign_key: true
  end
end
