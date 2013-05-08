#!/usr/bin/ruby

rootDir = Dir.pwd

project_names = ["BreakOut", "HelloWorldBlocks", "LeapPaint", "Quartz2DPaint"]

project_names.each do |i|
	puts rootDir + "/" + i
	Dir.chdir(rootDir + "/" + i){
		cmd =  "doxygen doxconfig.cfg"
	 puts  %x[#{cmd}]
	}
	Dir.chdir(rootDir + "/" + i + "/docs/latex"){
		cmd =  "make"
	 puts  %x[#{cmd}]
	}
	
end

