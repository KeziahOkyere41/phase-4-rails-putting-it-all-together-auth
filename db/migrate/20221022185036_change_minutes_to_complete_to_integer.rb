class ChangeMinutesToCompleteToInteger < ActiveRecord::Migration[6.1]
    def change
      change_column :recipes, :minutes_to_complete, :integer
    end
  end