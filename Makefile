
GIMPTOOL=gimptool-2.0

CC=gcc
CFLAGS=-O3 -Wall `pkg-config --cflags gtk+-2.0 gimp-2.0` -DGETTEXT_PACKAGE
LD=gcc
LDFLAGS=

ifdef WIN32
LDFLAGS+=-mwindows
endif

TARGET=dds

SRCS=dds.c ddsread.c ddswrite.c dxt.c
OBJS=$(SRCS:.c=.o)

LIBS=`pkg-config --libs gtk+-2.0 gimp-2.0 gimpui-2.0`
ifdef WIN32
LIBS+=-lopengl32 -lglu32 -lglut32 -lglew32
else
LIBS+=-L/usr/X11R6/lib -lGL -lGLU -lglut -lGLEW
endif

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) $(LIBS) -o $(TARGET)
		 
clean:
	rm -f *.o $(TARGET)

install: all
	$(GIMPTOOL) --install-bin $(TARGET)

.c.o:
	$(CC) -c $(CFLAGS) $<
	  
dds.o: dds.c ddsplugin.h dds.h dxt.h
ddsread.o: ddsread.c ddsplugin.h dds.h dxt.h
ddswrite.o: ddswrite.c ddsplugin.h dds.h dxt.h
dxt.o: dxt.c dds.h
