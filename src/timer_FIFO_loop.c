#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sched.h>
#include <errno.h>

int main(int argc, char** argv)
{
  struct  timeval tv;
  struct  timezone tz;
  int i, delay, num_iter, pid, priority;
  double init, start, stop;

  // FIFO stuff
  int j;
  struct sched_param my_sched_params;
  int scheduler, prio;

  // Start
  // Set this process to highest priority FIFO
  my_sched_params.sched_priority = sched_get_priority_max(SCHED_FIFO);
  // printf("Max FIFO priority is %d \n", my_sched_params.sched_priority);
  j = sched_setscheduler(getpid(), SCHED_FIFO, &my_sched_params);

  // if(errno == EPERM) {
  //   printf("Permission denied.\n");
  //   exit(1);
  // }

  // Now check actual parameters
  scheduler = sched_getscheduler(0); // 0 is shorthand for calling process ID
  prio = sched_getparam(getpid(), &my_sched_params);
  // printf("Scheduler is %d (0=TS, 1=FIFO, 2=RR) and priority is %d (sched_setscheduler returned %d)\n", scheduler, my_sched_params.sched_priority, j);
  if (argc < 3)
  {
    fprintf(stderr, "Usage: %s <sleep time..msec><num_iter>\n", argv[0]);
    exit(1);
  }

  //  progname=argv[0];
  delay = atoi(argv[1]);
  num_iter = atoi(argv[2]);
  pid = getpid();
  priority = getpriority(PRIO_PROCESS, pid);
  // printf("Delay is %d..num_iter is %d\n", delay, num_iter);
  gettimeofday( &tv, &tz);
  init = tv.tv_sec + tv.tv_usec * 0.000001;
  for (i = 0; i < num_iter; ++i)
  {
    gettimeofday( &tv, &tz);
    start = tv.tv_sec + tv.tv_usec * 0.000001;

// now loop continuously until time elapsed
//usleep(delay*1000);
    stop = start + delay * 0.001;
    do {
        gettimeofday( &tv, &tz);
        now = tv.tv_sec + tv.tv_usec * 0.000001;
    }
    while (now < stop);
    // printf("Time is %ld : %ld..slept for %lf ms\n", tv.tv_sec, tv.tv_usec, (stop - start) * 1000);
  }

  if(argc == 4) {
    // Print the CSV 
    // actual_time,expected_time,pid,niceness,delay,iterations,scheduler
    printf("%lf, %d, %d, %d, %d, %d, %d\n", (stop - init) * 1000, num_iter*delay, pid, priority, delay, num_iter, scheduler);
  }


  return 0;
}