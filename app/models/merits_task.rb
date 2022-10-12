class MeritsTask < ApplicationRecord
  has_many :task_dependencies, dependent: :destroy
  has_many :dependencies, through: :task_dependencies
  has_many :proceeding_type_merits_tasks, dependent: :destroy

  def dependency_names
    dependencies.map(&:name)
  end
end
