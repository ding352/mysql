FROM ubuntu:14.04
MAINTAINER Loading <dxf351@gmail.com>

RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update 
RUN apt-get -yq --force-yes install openssh-server openssh-client  mysql-server supervisor
RUN /etc/init.d/mysql start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'root';"&&\  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'root';"&&\  
    mysql -u root -proot -e "show databases;"  

RUN sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/my.cnf

ADD supervisord.conf /etc/supervisor/supervisord.conf

#RUN /etc/init.d/mysql restart
   
EXPOSE 3306  
   
#CMD ["/usr/bin/mysqld_safe"]

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

