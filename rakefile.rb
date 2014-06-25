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

=begin

namespace :test do

  task :all do |args|

    options = OpenStruct.new
    options.directory = ''
    options.output = 'console'

    OptionParser.new(args) do |opts|
      opts.banner = "Usage: rake user:create [options]"

      opts.on("-d", "--directory {path to tests}", "Path to directory with tests") do |directory|
        options.directory = directory
      end

      opts.on("-o", "--output [console|file|html]", "Set output type") do |o|
        options.output = o
      end

    end.parse!



    directory = File.join(File.dirname(__FILE__), options.directory)

    Dir["#{directory}/*.rb"].select { |f| File.file? f }.each do |f|
      p "ruby #{f} --output #{options.output}"
      system "ruby #{f} --output #{options.output}"
    end
  end

end
=end
