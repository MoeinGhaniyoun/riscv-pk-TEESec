// See LICENSE for license details.

#include <stdint.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>

int vsnprintf(char* out, size_t n, const char* s, va_list vl)
{
  asm volatile ("add x0, x0, x0\n\t");	
  bool format = false;
  asm volatile ("add x0, x0, x0\n\t");
  bool longarg = false;
  asm volatile ("add x0, x0, x0\n\t");
  size_t pos = 0;
  asm volatile ("add x0, x0, x0\n\t");
  for( ; *s; s++)
  {
    asm volatile ("add x0, x0, x0\n\t");
    if(format)
    {
      asm volatile ("add x0, x0, x0\n\t");	    
      switch(*s)
      {
        case 'l':
	asm volatile ("add x0, x0, x0\n\t");
          longarg = true;
	asm volatile ("add x0, x0, x0\n\t");
          break;
	asm volatile ("add x0, x0, x0\n\t");
        case 'p':
	asm volatile ("add x0, x0, x0\n\t");
          longarg = true;
	asm volatile ("add x0, x0, x0\n\t");
          if (++pos < n) out[pos-1] = '0';
	asm volatile ("add x0, x0, x0\n\t");
          if (++pos < n) out[pos-1] = 'x';
	asm volatile ("add x0, x0, x0\n\t");
        case 'x':
        {
	asm volatile ("add x0, x0, x0\n\t");
          long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
	asm volatile ("add x0, x0, x0\n\t");
          for(int i = 2*(longarg ? sizeof(long) : sizeof(int))-1; i >= 0; i--) {
		  asm volatile ("add x0, x0, x0\n\t");
            int d = (num >> (4*i)) & 0xF;
	    asm volatile ("add x0, x0, x0\n\t");
            if (++pos < n) out[pos-1] = (d < 10 ? '0'+d : 'a'+d-10);
           asm volatile ("add x0, x0, x0\n\t");
	  }
          longarg = false;
	  asm volatile ("add x0, x0, x0\n\t");
          format = false;
	  asm volatile ("add x0, x0, x0\n\t");
          break;
        }
        case 'd':
        {
		asm volatile ("add x0, x0, x0\n\t");
          long num = longarg ? va_arg(vl, long) : va_arg(vl, int);
		asm volatile ("add x0, x0, x0\n\t");
          if (num < 0) {
		  asm volatile ("add x0, x0, x0\n\t");
            num = -num;
		  asm volatile ("add x0, x0, x0\n\t");
            if (++pos < n) out[pos-1] = '-';
		  asm volatile ("add x0, x0, x0\n\t");
          }
		asm volatile ("add x0, x0, x0\n\t");
          long digits = 1;
		asm volatile ("add x0, x0, x0\n\t");
          for (long nn = num; nn /= 10; digits++)
            ;
		asm volatile ("add x0, x0, x0\n\t");
          for (int i = digits-1; i >= 0; i--) {
		  asm volatile ("add x0, x0, x0\n\t");
            if (pos + i + 1 < n) out[pos + i] = '0' + (num % 10);
		  asm volatile ("add x0, x0, x0\n\t");
            num /= 10;
		  asm volatile ("add x0, x0, x0\n\t");
          }
		asm volatile ("add x0, x0, x0\n\t");
          pos += digits;
		asm volatile ("add x0, x0, x0\n\t");
          longarg = false;
		asm volatile ("add x0, x0, x0\n\t");
          format = false;
		asm volatile ("add x0, x0, x0\n\t");
          break;
        }
        case 's':
        {
		asm volatile ("add x0, x0, x0\n\t");
          const char* s2 = va_arg(vl, const char*);
		asm volatile ("add x0, x0, x0\n\t");
          while (*s2) {
		  asm volatile ("add x0, x0, x0\n\t");
            if (++pos < n)
		    asm volatile ("add x0, x0, x0\n\t");
              out[pos-1] = *s2;
		  asm volatile ("add x0, x0, x0\n\t");
            s2++;
		  asm volatile ("add x0, x0, x0\n\t");
          }
		asm volatile ("add x0, x0, x0\n\t");
          longarg = false;
		asm volatile ("add x0, x0, x0\n\t");
          format = false;
		asm volatile ("add x0, x0, x0\n\t");
          break;
        }
        case 'c':
        {
		asm volatile ("add x0, x0, x0\n\t");
          if (++pos < n) out[pos-1] = (char)va_arg(vl,int);
        asm volatile ("add x0, x0, x0\n\t");  
	longarg = false;
	  asm volatile ("add x0, x0, x0\n\t");
		  asm volatile ("add x0, x0, x0\n\t");
          format = false;
	  asm volatile ("add x0, x0, x0\n\t");
          break;
        }
        default:
          break;
      }
    }
    else if(*s == '%')
      format = true;
    else
      if (++pos < n) out[pos-1] = *s;
  }
  if (pos < n)
    out[pos] = 0;
  else if (n)
    out[n-1] = 0;
  return pos;
}

int snprintf(char* out, size_t n, const char* s, ...)
{
  va_list vl;
  va_start(vl, s);
  int res = vsnprintf(out, n, s, vl);
  va_end(vl);
  return res;
}
