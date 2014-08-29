class CreateKensas < ActiveRecord::Migration
  require 'csv'
  def change
    create_table :kensas, options: "ENGINE=Mroonga" do |t|
      t.string :flag
      t.string :name
      t.string :code
      t.string :description

      t.timestamps
    end
    mroonga_index(:kensas, :name, parser: "TokenBigram")
    
    file = Dir.glob("../s.csv")[0]
    CSV.foreach(file, "r:shift_jis:utf-8") do |row|
      next if (row[89] != "2") || (row[4] =~ /加算/)
      Kensa.create! flag: row[0], name: row[4], code: row[2]
    end
    p Kensa.count
  end
end
