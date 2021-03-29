class MeritsTask < ApplicationRecord
  has_many :task_dependencies
  has_many :dependencies, through: :task_dependencies
end
