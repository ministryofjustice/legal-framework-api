class AddDisplayRulesToProceedingTypeMeritsTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :proceeding_type_merits_tasks, :display_rules, :string
  end
end
