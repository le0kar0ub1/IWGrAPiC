CXX		:=	g++

TARGET	:=	$(target).bin

BUILDIR	:=	target/$(target)

INCLUDE	:=	$(addprefix -I, $(target)/inc mktoolchain/toolchain/include)

CXXFLAGS :=	    $(INCLUDE)		    \
				-Wall 				\
				-Wextra 			\
				-Winline			\
				-Wuninitialized		\

LDFLAGS	:=  -L mktoolchain/toolchain/libs    		    	\
            -l grapic 										\
            -l SDL2											\
            -l SDL2_image									\
            -l SDL2_ttf										\
            -Wl,-rpath="$(PWD)/mktoolchain/toolchain/libs"

EXTSRC := cpp
EXTOBJ := o

SRC :=	$(wildcard $(target)/src/*.$(EXTSRC) $(target)/src/**/*.$(EXTSRC))

OBJ := 	$(patsubst $(target)/src/%.$(EXTSRC), $(BUILDIR)/%.$(EXTOBJ), $(SRC))

.PHONY: all run clean install target-dir

target-dir:
	@(test -d $(target) && test -d $(target)/src) || (echo "Invalid target directory" && exit 1)

build: target-dir $(TARGET)

project:
	mkdir -p $(target)/{src,inc}

debug ?= 0
ifeq ($(debug), 1)
    CXXFLAGS += -D DEBUG -g3
endif

$(TARGET): $(OBJ)
	@$(CXX) -o $(TARGET) $(OBJ) $(LDFLAGS)
	@-echo -e " LINKED      $@"

clean:
	@rm -rf $(BUILDIR) *.bin

$(BUILDIR)/%.$(EXTOBJ): $(target)/src/%.$(EXTSRC)
	@mkdir -p $(shell dirname $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@
	@-echo -e "    CXX      $@"

install:
	@./mktoolchain/mktoolchain

run: $(TARGET)
	@./$(TARGET)
