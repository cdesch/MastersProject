#!/usr/bin/ruby


puts Dir.pwd
cmd = "doxygen doxconfig.cfg"
puts %x[#{cmd} ]


Dir.chdir(Dir.pwd + "/docs/latex"){
		cmd =  "make"
	 puts  %x[#{cmd}]
	}


