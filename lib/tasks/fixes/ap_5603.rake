namespace :fixes do
  desc "Remove an proceeding type"
  task :remove_proceeding_type, [:ccms_code] => :environment do |_task, args|
    proceeding_type = ProceedingType.find_by(ccms_code: args[:ccms_code])
    puts "----------------------------------------------------------"

    if proceeding_type
      puts "Found ProceedingType #{proceeding_type.ccms_code}!"
      puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
      puts "This will delete:"
      puts ""
      puts "proceeding_type - ccms_code: #{proceeding_type.ccms_code}, meaning: #{proceeding_type.meaning} "
      puts "#{proceeding_type.proceeding_type_merits_tasks.count} proceeding_type_merits_tasks"
      puts "#{proceeding_type.default_cost_limitations.count} default_cost_limitations"
      puts "#{proceeding_type.proceeding_type_service_levels.count} proceeding_type_service_levels"
      puts ""

      print "Do you want to continue (yes|no)? "
      input = $stdin.gets.chomp

      if input.downcase == "yes"
        proceeding_type.destroy!

        puts "Deleted proceeding_type #{proceeding_type.ccms_code} with meaning \"#{proceeding_type.meaning}\""
        puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
      else
        puts "Cancelled!"
      end
    else
      puts "ProceedingType #{args[:ccms_code]} not found!"
    end
    puts "----------------------------------------------------------"
  end

  desc "AP-55603: remove unused proceeding type SE099E"
  task remove_proceeding_type_SE099E: :environment do
    Rake::Task["fixes:remove_proceeding_type"].execute(ccms_code: "SE099E")
  end
end
