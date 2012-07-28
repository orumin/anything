TARGET=
CC=gcc
CXX=g++
CFLAGS=-g -O2 -w
CXXFLAGS=$(CFLAGS)
LDFLAGS=-static-libgcc -static-libstdc++
INCDIR=-I"./DxLib/"
LIBDIR=-L"./DxLib/"
LIBS=-lDxLib -lDxUseCLib -lDxDrawFunc -ljpeg -lpng -lzlib -ltheora_static -lvorbis_static\
	 -lvorbisfile_static -logg_static -lbulletdynamics -lbulletcollision -lbulletmath
LIBS+=-lgdi32
OBJS=main.o

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCDIR) $(LIBDIR) -o $@ $^ $(LIBS) 

clean:
	@rm -fr $(TARGET).exe $(OBJS) *~ *.swp
