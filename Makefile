test: driver.c scheme_entry.c
	@as scheme_entry.s 
	@gcc -Wall -Wextra driver.c scheme_entry.o -o test

template: scheme_entry.c
	gcc -S --omit-frame-pointer scheme_entry.c
