/*server.c*/
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <netinet/in.h>

#define PORT            4321
#define BUFFER_SIZE        1024
#define MAX_QUE_CONN_NM   5
int main()
{
     struct sockaddr_in server_sockaddr,client_sockaddr;
char key[32]="security";
     int sin_size,recvbytes;
     int sockfd, client_fd;
     char buf[BUFFER_SIZE];
     

 struct timeval timeout;      
    timeout.tv_sec = 10;
    timeout.tv_usec = 0;



     /*建立socket连接*/
     if ((sockfd = socket(AF_INET,SOCK_STREAM,0))== -1)
     {
          perror("socket");
          exit(1);
     }
     printf("Socket id = %d\n",sockfd);

// add time out part

    if (setsockopt (sockfd, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,
                sizeof(timeout)) < 0)
        error("setsockopt failed\n");

    if (setsockopt (sockfd, SOL_SOCKET, SO_SNDTIMEO, (char *)&timeout,
                sizeof(timeout)) < 0)
        error("setsockopt failed\n");
     
     /*设置sockaddr_in 结构体中相关参数*/
     server_sockaddr.sin_family = AF_INET;
     server_sockaddr.sin_port = htons(PORT);
     server_sockaddr.sin_addr.s_addr = INADDR_ANY;
     bzero(&(server_sockaddr.sin_zero), 8);
     
     int i = 1;/* 允许重复使用本地地址与套接字进行绑定 */
     setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &i, sizeof(i));
     
     /*绑定函数bind()*/
     if (bind(sockfd, (struct sockaddr *)&server_sockaddr, 
                   sizeof(struct sockaddr)) == -1)
     {
          perror("bind");
          exit(1);
     }
     printf("Bind success!\n");
     
     /*调用listen()函数，创建未处理请求的队列*/
     if (listen(sockfd, MAX_QUE_CONN_NM) == -1)
     {
          perror("listen");
          exit(1);
     }
     printf("Listening....\n");
     
     /*调用accept()函数，等待客户端的连接*/
     if ((client_fd = accept(sockfd, 
                  (struct sockaddr *)&client_sockaddr, &sin_size)) == -1)
     {
          perror("accept");
          exit(1);
     }
     
     /*调用recv()函数接收客户端的请求*/
     memset(buf , 0, sizeof(buf));
     if ((recvbytes = recv(client_fd, buf, BUFFER_SIZE, 0)) == -1)
     {
          perror("recv");
          exit(1);
     }
     printf("Received a message: %s\n", buf);
     // ----------------Add buffer key compare
int chki;
    /* for ( chki=0; buf[chki] !=' '; chki++)
{
	if (strcmp(buffer[chki], key[chki]) ==0)
       {
           printf("ok continue \n ") ;
       } 

	break;
}   

i*/


chki = strcmp(buf,key);
if (chki==0)
    {
   printf("the key is ok %d \n", chki);

//----------------------
     close(sockfd);
   //  exit(0);
   if(!chki)
   return(0);
   }
else

   printf("the key is wrong  %d \n", chki);
return(1);
}

