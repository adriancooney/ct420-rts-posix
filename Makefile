posix_getres: src/posix_getres.c
	gcc -o ./out/posix_getres src/posix_getres.c
	./out/posix_getres

timer_usleep: src/timer_usleep.c
	gcc -o ./out/timer_usleep src/timer_usleep.c
	./out/timer_usleep

clean:
	rm -r out
	mkdir out