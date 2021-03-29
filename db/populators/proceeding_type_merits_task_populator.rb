class ProceedingTypeMeritsTaskPopulator
  DATA_FILE = Rails.root.join('db/seed_data/proceeding_type_merits_task.yml').freeze

  def self.call
    new.call
  end

  def call
    proceeding_type_keys.each do |proceeding_type_key, task_names|
      populate(proceeding_type_key, task_names)
    end
  end

  private

  def populate(proceeding_type_key, task_names)
    proceeding_type = ProceedingType.find_by!(ccms_code: proceeding_type_key)
    task_names.each_with_index do |task_name, index|
      task = MeritsTask.find_by!(name: task_name)
      rec = ProceedingTypeMeritsTask.find_by(proceeding_type_id: proceeding_type.id, merits_task_id: task.id) || ProceedingTypeMeritsTask.new
      rec.update!(proceeding_type_id: proceeding_type.id, merits_task_id: task.id, sequence: (index + 1) * 10)
    end
  end

  def proceeding_type_keys
    @proceeding_type_keys ||= YAML.load_file(DATA_FILE)
  end
end
