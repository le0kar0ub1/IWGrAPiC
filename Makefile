CXX		:=	g++

TARGET	:=	project

BUILDIR	:=	target

INCLUDE	:=	$(addprefix -I, inc /usr/include/SDL2)

CXXFLAGS :=	    $(INCLUDE)		    \
				-Wall 				\
				-Wextra 			\
				-Winline			\
				-Wuninitialized		\

LDFLAGS	:=  -L mktoolchain/build    \
            -l grapic 				\
            -I /usr/include/SDL2/ 	\
            -Wl,-rpath="$(PWD)/mktoolchain/build"

EXTSRC := cpp
EXTOBJ := o

SRC :=	$(wildcard src/*.$(EXTSRC) src/**/*.$(EXTSRC))

OBJ := 	$(patsubst src/%.$(EXTSRC), $(BUILDIR)/%.$(EXTOBJ), $(SRC))

.PHONY: all run clean

all: $(TARGET)

disassemble: $(TARGET)
	@objdump --no-show-raw-insn -d -Mintel $(TARGET) | source-highlight -s asm -f esc256 | less -eRiMX

debug ?= 0
ifeq ($(debug), 1)
    CXXFLAGS += -D DEBUG -g3
endif

re:	clean all

$(TARGET):	$(OBJ)
	@$(CXX) -o $(TARGET) $(OBJ) $(LDFLAGS)
	@-echo -e " LINKED      $@"

clean:
	@rm -rf $(BUILDIR) $(TARGET)

$(BUILDIR)/%.$(EXTOBJ): src/%.$(EXTSRC)
	@mkdir -p $(shell dirname $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@
	@-echo -e "    CXX      $@"

vg: $(TARGET)
	@valgrind	--leak-check=full 		\
				--show-leak-kinds=all 	\
				--track-origins=yes 	\
				--verbose 				\
				$(TARGET)

run: $(TARGET)
	@./$(TARGET)