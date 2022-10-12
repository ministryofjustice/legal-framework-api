class ProceedingTypeMeritsTaskPopulator
  DATA_FILE = Rails.root.join("db/seed_data/proceeding_type_merits_task.yml").freeze

  def self.call
    new.call
  end

  def call
    proceeding_type_keys.each do |seed_hash|
      @loop_index = 0
      populate(seed_hash["ccms_code"], seed_hash["questions"])
    end
  end

private

  def populate(proceeding_type_key, task_names, display_rules: nil)
    proceeding_type = ProceedingType.find_by!(ccms_code: proceeding_type_key)
    task_names.each do |task_name|
      if task_name.is_a?(Hash)
        populate(proceeding_type_key, task_name.values.flatten, display_rules: task_name.keys.first)
        next
      end
      @loop_index += 1
      task = MeritsTask.find_by!(name: task_name)
      rec = ProceedingTypeMeritsTask.find_by(proceeding_type_id: proceeding_type.id, merits_task_id: task.id) || ProceedingTypeMeritsTask.new
      rec.update!(proceeding_type_id: proceeding_type.id, merits_task_id: task.id, display_rules:, sequence: @loop_index)
    end
  end

  def proceeding_type_keys
    @proceeding_type_keys ||= YAML.load_file(DATA_FILE)
  end
end
