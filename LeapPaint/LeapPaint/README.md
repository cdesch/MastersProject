LeapPuzz
========

[Project Home & Wiki]( http://hci.montclair.edu/groups/leap/)

#Requirements Specification

##Interface
 - HUD Requirement to render a cursor where the pointable is intersecting with the screen. The cursor should show the color that will be painting on the screen
 - Ring and round cursor to indicate drawing or not drawing.

##Features

 - Change Colors
 - Change Brushes
 - Eraser
 - Change size of brush
 - Reset drawing
 - Change Opacity of brushes


#Unit Tests




#Libraries & Sub Modules

 - [Cocos2d 2.0](http://www.cocos2d-iphone.org/)
 - [CCControlExtension](https://github.com/YannickL/CCControlExtension)
 -

#Build Settings

 - Valid Architecture i386 x86_64
 - Other Linker Flags -lz -ObjC
 - C Language Dialect GNU99 -std=gnu99
 - C ++ Language Dialect GNU++11 -std=gnu++11
 - C ++ Standard Library libc++ (LLVM C++ standard lib)

 - run script after build:

	echo TARGET_BUILD_DIR=${TARGET_BUILD_DIR}
	echo TARGET_NAME=${TARGET_NAME}
	cd ${TARGET_BUILD_DIR}/${TARGET_NAME}.app/Contents/MacOS
	ls -la
	install_name_tool -change @loader_path/libLeap.dylib @executable_path/../Resources/libLeap.dylib ${TARGET_NAME}

#Documentation

Documentation is done using [Doxygen](doxygen.org)





