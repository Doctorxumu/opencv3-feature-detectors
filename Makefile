ifeq ($(OS),Darwin)
CC=g++
else
CC=g++-4.9
endif

OS := $(shell uname)

SRC_DIR = src
BUILD_DIR = build

CPP_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(addprefix build/obj/,$(notdir $(CPP_FILES:.cpp=.o)))
LD_FLAGS := -L/usr/local/Cellar/boost/1.60.0_2/lib -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn -lopencv_dpm -lopencv_fuzzy -lopencv_line_descriptor -lopencv_optflow -lopencv_plot -lopencv_reg -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_rgbd -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_face -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_flann -lopencv_xobjdetect -lopencv_objdetect -lopencv_ml -lopencv_xphoto  -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_core
CC_FLAGS := -std=c++11 -Wall 

cv3:
	g++ $(LD_FLAGS) cv3.cpp -o $(BUILD_DIR)/$@ $^


main:
	g++ $(LD_FLAGS) main.cpp -o $(BUILD_DIR)/$@ $^

app: $(OBJ_FILES)
	g++ $(LD_FLAGS) -o $(BUILD_DIR)/$@ $^

build/obj/%.o: src/%.cpp 
	g++ $(CC_FLAGS) -c -o $@ $<

build/obj/%.o: src/gpio/%.cpp 
	g++ $(CC_FLAGS) -c -o $@ $<

clean:
	rm -rf build/obj/* && rm build/app

run:
	cd build && sudo ./cv3 1.png 2.png

doc:
	doxygen utils/Doxyfile.in