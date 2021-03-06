#!/usr/bin/ruby

#This script generates the documentation for each project in the workspace. 

require "rubygems"
require 'ruby-progressbar'

rootDir = Dir.pwd
#Project Names
project_names = ["BreakOut", "HelloWorldBlocks", "LeapPaint", "Quartz2DPaint"]

progressbar = ProgressBar.create(:format => '%a %B %p%% %t')
project_names.each do |i|
	#puts rootDir + "/" + i
	puts "Generating LaTex Documentation for: " + i  
	Dir.chdir(rootDir + "/" + i){
		cmd =  "doxygen doxconfig.cfg"
		#puts  %x[#{cmd}]
		 %x[#{cmd}]
	}
	puts "Generating PDF File from LaTex for: " + i  
	Dir.chdir(rootDir + "/" + i + "/docs/latex"){
		 cmd =  "make"
		 puts  %x[#{cmd}]
		 %x[#{cmd}]
	}
	#Update the Progress bar
	progressbar.progress += (project_names.count * 2) / 100
end

