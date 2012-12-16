require 'rubygems'
require 'bundler/setup'
require 'listen'

def usage
  puts 'Usage: ruby sync.rb local_path host:remote_path'
  exit 1
end

usage unless ARGV.length == 2
usage unless (idx = ARGV[1].index ':')

local = File.realdirpath File.expand_path ARGV[0]
host, path = ARGV[1][0,idx], ARGV[1][idx+1..-1]
remote = "#{host}:#{`ssh #{host} 'readlink #{path}'`}".strip
ignore = [%r{tmp/}, /\.(ya?ml|sql|log|tmp)$/]

puts "Sync: #{local} -> #{remote}"

Listen.to(local, ignore: ignore, relative_paths: true) do |modified, added, removed|
  (modified + added + removed).each do |path|
    source = File.join local, path
    target = File.join remote, path
    `rsync -rpvzq #{source} #{target}`
    puts path
  end
end
