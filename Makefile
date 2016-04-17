posix_getres: src/posix_getres.c
	gcc -o ./out/posix_getres src/posix_getres.c

timer_usleep: src/timer_usleep.c
	gcc -lrt -o ./out/timer_usleep src/timer_usleep.c

fifo: src/timer_mod_FIFO.c
	gcc -lpthread -o ./out/fifo src/timer_mod_FIFO.c

clean:
	rm -r out
	mkdir out