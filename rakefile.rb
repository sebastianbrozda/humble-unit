namespace :test do

  task :all, [:d] do |t, args|
    unless args[:d]
      p "you set pass directory path eg. rake test:all['my_dir/with_test/']"
      exit
    end

    directory = File.join(File.dirname(__FILE__), args[:d])
    Dir["#{directory}/*.rb"].select { |f| File.file? f }.each do |f|
      system "ruby #{f}"
    end
  end

end