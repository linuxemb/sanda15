//sting 1 - Opening a serial port. 
#include <stdio.h>   /* Standard input/output definitions */
#include <string.h>  /* String function definitions */
#include <unistd.h>  /* UNIX standard function definitions */
#include <fcntl.h>   /* File control definitions */
#include <errno.h>   /* Error number definitions */
#include <termios.h> /* POSIX terminal control definitions */

/*
 * 'pen_port()' - Open serial port 1.
 *
 * Returns the file descriptor on success or -1 on error.
 */

int
open_port(void)
{
  int fd; /* File descriptor for the port */


  fd = open("/dev/ttyUSB0", O_RDWR | O_NOCTTY | O_NDELAY);
  if (fd == -1)
  {
   /*
    * Could not open the port.
    */

printf ("fe == %d" , fd);
    perror("open_port: Unable to open /dev/ttyf1 - ");
  }
  else
 
    printf("in else : open_port: sucess  - \n");
    fcntl(fd, F_SETFL, 0);

printf ("%d" , fd);
  return (fd);
}
int main()
{

open_port();

//    printf("open_port: sucess  - \n");
return 0;

}
