class CreateIncomes < ActiveRecord::Migration[6.1]
  def change
    create_table :incomes do |t|
      t.string :title
      t.decimal :amount
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
