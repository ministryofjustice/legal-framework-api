class MeritsTask < ApplicationRecord
  has_many :task_dependencies, dependent: :destroy
  has_many :dependencies, through: :task_dependencies

  def dependency_names
    dependencies.map(&:name)
  end
end
