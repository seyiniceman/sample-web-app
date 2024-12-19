FROM amazonlinux:2.0.20241001.0

# Install dependencies
RUN yum update -y && \
    yum install -y httpd && \
    yum search wget && \
    yum install wget -y && \
    yum install unzip -y

# change directory
RUN cd /var/www/html

# download webfiles
RUN wget https://github.com/seyiniceman/Webpagefiles/archive/refs/heads/main.zip

# unzip folder
RUN unzip main.zip

# copy files into html directory
RUN cp -r Webpagefiles-main/* /var/www/html/

# remove unwanted folder
RUN rm -rf Webpagefiles-main main.zip

# exposes port 80 on the container
EXPOSE 80

# set the default application that will start when the container start
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
