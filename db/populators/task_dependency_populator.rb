class TaskDependencyPopulator
  DATA_FILE = Rails.root.join("db/seed_data/task_dependencies.yml").freeze

  def self.call
    new.call
  end

  def call
    TaskDependency.transaction do
      repopulate!
    end
  end

private

  def repopulate!
    TaskDependency.delete_all
    seed_data.each do |task_name, dependency_names|
      dependency_names.each do |dependency_name|
        populate(task_name, dependency_name)
      end
    end
  end

  def seed_data
    @seed_data ||= YAML.load_file(DATA_FILE)
  end

  def populate(task_name, dependency_name)
    task = MeritsTask.find_by!(name: task_name)
    dependency = MeritsTask.find_by!(name: dependency_name)
    TaskDependency.create!(merits_task: task, dependency:)
  end
end
