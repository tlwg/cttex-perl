#include "ttool.h"
#include <stdlib.h>
#include <string.h>

void shift(char *str) {
  int i, len;
  len = strlen(str);
  for(i=0;i<len;i++)
    str[i] ++;
}

char * my_cut(char *str) {
  int i, len;
  char *ptr;

  ptr=(char *)malloc(strlen(str));
  len=strlen(str);
  for(i=0;i<len;i++)
    ptr[i] = str[i]+1;
  return ptr;
}
