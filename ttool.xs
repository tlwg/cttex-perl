#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include <stdlib.h>
#include <ttool.h>

static int
not_here(s)
char *s;
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(name, arg)
char *name;
int arg;
{
    errno = 0;
    switch (*name) {
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = ttool		PACKAGE = ttool		


double
constant(name,arg)
	char *		name
	int		arg


void
shift(str)
	char *	str

void 
ttsetcode(code)
  int code
CODE:
  setcode(code);

void
ttcut(str)
	char *	str
PREINIT:
  char *temp;
PPCODE:
  temp=malloc(strlen(str)*2);
  dooneline(str,temp);
  EXTEND(SP,1);
  PUSHs(sv_2mortal(newSVpv(temp,strlen(temp))));
  free(temp);

void
ttcutwbr(str)
	char *	str
PREINIT:
  unsigned char *temp,*temp2;
  int i,j;
  int prevcode;
PPCODE:
  prevcode=getcode();
  setcode(254);
  temp=malloc(strlen(str)*2);
  temp2=malloc(strlen(str)*2+100);
  dooneline(str,temp);
  i=j=0;
  while(temp[i]) {
    if(temp[i]==254) {
      temp2[j++]= '<';
      temp2[j++]= 'W';
      temp2[j++]= 'B';
      temp2[j++]= 'R';
      temp2[j++]= '>';
    }
    else
      temp2[j++]=temp[i];
    i++;
  }
  EXTEND(SP,1);
  PUSHs(sv_2mortal(newSVpv(temp2,j)));
  free(temp);
  free(temp2);
  setcode(prevcode);

void 
ttcut2list(str)
  char * str
PREINIT:
  unsigned char *temp;
  int prevcode, i, count, head;
PPCODE:
  temp=malloc(strlen(str)*2);
  prevcode=getcode();
  setcode(254);
  dooneline(str,temp);
  i=count=0;
  while(temp[i]) {
    if(temp[i]==254) count++;
    i++;
  }
  EXTEND(SP,1+count);
  i = head = 0;
  while(temp[i]) {
    if(temp[i]==254) {
      PUSHs(sv_2mortal(newSVpv(temp+head,i-head)));
      head=i+1;
    }
    i++;
  }
  PUSHs(sv_2mortal(newSVpv(temp+head,i-head)));
  free(temp);
  setcode(prevcode);

void
ttfixorder(str)
	char *	str
CODE:
  fixline(str);
