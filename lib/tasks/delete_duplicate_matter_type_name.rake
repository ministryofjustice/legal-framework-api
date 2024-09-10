namespace :migrate do
  desc "AP-5298: delete duplicate matter type names"

  task delete_matter_type_name: :environment do
    matter_type = MatterType.all
    Rails.logger.info "Delete duplicate MatterType names"
    Rails.logger.info "----------------------------------------------------------"
    Rails.logger.info "Current matter type names: #{matter_type.pluck(:name)}"
    Rails.logger.info "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    Benchmark.benchmark do |bm|
      bm.report("Migrate:") do
        ActiveRecord::Base.transaction do
          domestic_abuse = matter_type.find_by(name: "domestic abuse (DA)")

          ThresholdWaiver.find_by(matter_type: domestic_abuse).destroy!

          domestic_abuse.destroy!

          section_eight = matter_type.find_by(name: "section 8 children (S8)")
          section_eight.destroy!

          domestic_abuse = matter_type.find_by(name: "special children act (SCA)")
          domestic_abuse.destroy!
        end
      end
    end
    Rails.logger.info "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    Rails.logger.info "Updated matter type names: #{matter_type.pluck(:name)}"
    Rails.logger.info "----------------------------------------------------------"
  end
end
