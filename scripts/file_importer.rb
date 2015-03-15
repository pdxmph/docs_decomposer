require 'find'

dirs = ["pe","puppet","forge","facter","hiera"]

dirs.each do |d|
  Find.find("/Users/mike/Documents/puppet-docs/source/#{d}") do |f|
   # print file and path to screen if filename ends in ".mp3"
    puts f.gsub(/\/Users\/mike\/Documents\/puppet-docs/,"") if f.match(/\.(markdown|md)\Z/)
  end
end
