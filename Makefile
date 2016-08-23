test: giles.scm driver.c scheme_entry.c
	@guile giles.scm
	@as scheme_entry.s -o scheme_entry.o 
	@gcc -Wall -Wextra driver.c scheme_entry.o -o test

template: scheme_entry.c
	gcc -S --omit-frame-pointer scheme_entry.c
