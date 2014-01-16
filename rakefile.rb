begin
  require 'bundler/setup'
  require 'albacore'
  require 'fileutils'

rescue LoadError
  puts 'Bundler and all the gems need to be installed prior to running this rake script. Installing...'
  system("gem install bundler --source http://rubygems.org")
  sh 'bundle install'
  system("bundle exec rake", *ARGV)
  exit 0
end

task :default => [ :clean, :createpackages ]

nugetfolder = '../nugets'

desc "Prepares the working directory for a new build"
task :clean do
  filesToClean = FileList.new
  filesToClean.include('../**/*.nupkg')
  filesToClean.exclude("#{nugetfolder}")
  # Clean template results.
  FileUtils.rm_rf filesToClean
  
  Dir.mkdir "#{nugetfolder}" unless File.exists?("#{nugetfolder}")
end

desc "Package build artifacts as a NuGet package"
task :createpackages => [ :clean ] do
	# We blindly assume that we are in a directory where the root contains all machine repos
	Dir.glob("../**/*.nuspec") do |nuspec|
		sh "nuget pack #{nuspec} -Version 0.0.0 -OutputDirectory #{nugetfolder}"
	end
end