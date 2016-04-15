#include <stdio.h>
#include <unistd.h>
#include <time.h>

int main() 
{ 
  struct timespec clock_res; 
  int stat; 
  stat = clock_getres(CLOCK_REALTIME, &clock_res); 
  printf("Clock resolution is %ld sec, %ld nseconds\n", clock_res.tv_sec, clock_res.tv_nsec); 
  return 0; 
} 