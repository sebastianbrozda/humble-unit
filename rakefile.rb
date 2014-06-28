namespace :test do

  task :all, :directory, :output do |t, args|
    unless args[:directory]
      p "you set pass directory path eg. rake test:all['my_dir/with_test/']"
      exit
    end

    output = 'console'
    output = args[:output] if args[:output]
    directory = File.join(File.dirname(__FILE__), args[:directory])

    Dir["#{directory}/*.rb"].select { |f| File.file? f }.each do |f|
      system "ruby #{f} --output #{output}"
    end
  end

end