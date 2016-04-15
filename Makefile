posix_getres: src/posix_getres.c
	gcc -o ./out/posix_getres src/posix_getres.c

timer_usleep: src/timer_usleep.c
	gcc -o ./out/timer_usleep src/timer_usleep.c

clean:
	rm -r out
	mkdir out