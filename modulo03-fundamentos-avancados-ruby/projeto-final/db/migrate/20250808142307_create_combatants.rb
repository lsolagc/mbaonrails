class CreateCombatants < ActiveRecord::Migration[8.0]
  def change
    create_table :combatants do |t|
      t.integer :armor_class, null:false, default: 10
      t.integer :strength, null: false, default: 10
      t.integer :dexterity, null: false, default: 10
      t.integer :constitution, null: false, default: 10
      t.integer :intelligence, null: false, default: 10
      t.integer :wisdom, null: false, default: 10
      t.integer :charisma, null: false, default: 10
      t.integer :max_hitpoints, null:false, default: 10
      t.references :combatable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
