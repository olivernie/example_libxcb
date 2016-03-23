# install g++ and libxcb1-dev
# sudo apt-get install g++ libxcb1-dev -y

TARGET = test

SRCS =
SRCS += drawbox.c

OBJS = $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SRCS)))

CWARNING_FLAGS = -Wno-long-long -Wformat -Wall -Werror -Wno-missing-field-initializers -Wno-unused-value

CPPFLAGS  = -g 
#CPPFLAGS += -DDEBUG 
#CFLAGS    = -std=c99 $(CWARNING_FLAGS)
CFLAGS    = $(CWARNING_FLAGS)
CXXFLAGS  = $(CWARNING_FLAGS)
#CXXFLAGS += -print-file-name=xcb
#CXXFLAGS += -print-search-dirs

LDFLAGS  =

LIBDEP   =
LDADD    = -lxcb

CC      = gcc
CXX     = g++
LD      = ld
STRIP   = strip

DEPEND_DIR = depend

CLEAN_FILES += $(TARGET) $(OBJS) .depend $(DEPEND_DIR)/*.d

# command macro to generate dependency file
MAKEDEPEND = echo "make dependency: " $< ; \
    [ -d $(DEPEND_DIR) ] || mkdir $(DEPEND_DIR); \
    $(CXX) -M $(CPPFLAGS) $(CXXFLAGS) $< > $(DEPEND_DIR)/$*.d ;

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LDADD)

%.o : %.c
	@$(MAKEDEPEND)
	$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<

%.o : %.cpp
	@$(MAKEDEPEND)
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) -o $@ $<

-include $(DEPEND_DIR)/*.d

.PHONY: clean
clean:
	rm -f $(CLEAN_FILES)


