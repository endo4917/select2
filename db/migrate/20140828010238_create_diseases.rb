class CreateDiseases < ActiveRecord::Migration
  require 'csv'
  def change
    create_table :diseases do |t|
      t.string :flag
      t.string :name
      t.string :icd
      t.string :code
      t.string :description

      t.timestamps
    end
    mroonga_index(:diseases, :description, parser: "TokenBigramSplitSymbolAlphaDigit")

    file = Dir.glob("../b_*")[0]
    CSV.foreach(file, "r:shift_jis:utf-8") do |row|
      Disease.create! flag: row[0], name: row[5], icd: row[13], code: row[2], description: row[13] + row[5]
    end
    p Disease.count
  end
end
