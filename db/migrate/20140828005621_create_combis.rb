class CreateCombis < ActiveRecord::Migration
  def change
    create_table :combis do |t|
      t.integer :kensa_id
      t.integer :disease_id
      t.string :rank
      t.string :parent

      t.timestamps
    end
    mroonga_index(:combis, :parent, parser: "TokenBigram")
  end
end
