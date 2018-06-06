namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern
      task task_name => :environment do
        load(filename) if File.exist?(filename)
      end
    end

    desc "Load the seed data from SEED_FILENAME #{ENV['SEED_FILENAME']}"
    task :from_file => :environment do
      p "Load the seed data from SEED_FILENAME #{ENV['SEED_FILENAME']}"
      seed_file = File.join(Rails.root, 'db/seeds', ENV['SEED_FILENAME'])
      if File.exist?(seed_file)
        load(seed_file)
      else
        p "Not exist SEED_FILENAME '#{seed_file}'"
      end
    end
  end
end
