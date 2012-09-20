# Buzen project makefile
# `make` to build the parser
# `make clean` to remove the products
# `make test` to run tests

all: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -o parser
	gcc pre.c -o pp
lex.yy.c: buzen.l
	flex buzen.l
y.tab.c: buzen.y
	bison -ydv buzen.y
clean:
	-@rm parser lex.* y.* output pp wo_comm 2>/dev/null || true
test:
	# Running a sample program through the preprocessor and the actual parser
	./pp tests/big.buz
	./parser wo_comm
