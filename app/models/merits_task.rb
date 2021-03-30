class MeritsTask < ApplicationRecord
  has_many :task_dependencies, dependent: :destroy
  has_many :dependencies, through: :task_dependencies
end
