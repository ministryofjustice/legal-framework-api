namespace :migrate do
  desc "AP-5298: update matter type names"

  task update_matter_type_name: :environment do
    matter_type = MatterType.all
    Rails.logger.info "Update MatterType names"
    Rails.logger.info "----------------------------------------------------------"
    Rails.logger.info "Current matter type names: #{matter_type.pluck(:name)}"
    Rails.logger.info "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    Benchmark.benchmark do |bm|
      bm.report("Migrate:") do
        ActiveRecord::Base.transaction do
          domestic_abuse = matter_type.find_by(name: "Domestic abuse")
          domestic_abuse.update!(name: "domestic abuse (DA)")

          section_eight = matter_type.find_by(name: "Children - section 8")
          section_eight.update!(name: "section 8 children (S8)")

          domestic_abuse = matter_type.find_by(name: "Special Children Act")
          domestic_abuse.update!(name: "special children act (SCA)")
        end
      end
    end
    Rails.logger.info "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    Rails.logger.info "Updated matter type names: #{matter_type.pluck(:name)}"
    Rails.logger.info "----------------------------------------------------------"
  end
end
