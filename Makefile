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
	bison -y -d buzen.y
clean:
	rm parser lex.* y.* output pp new_copy
test:
	# ----- (1) Small test -----
	./parser tests/small.buz
	# ----- (2) BIG test -------
	./parser tests/big.buz
	# - Preproccessor testing --
	./pp tests/with_comments
