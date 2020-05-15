FROM nginx:1.17.8-alpine
#
#ARG USER=www-data
#ARG USER_ID=1000
#ARG GROUP_ID=1000
#ARG GROUP=docker
#ENV user=$USER
#ENV group=$GROUP
#
#USER root
#COPY shell.sh /usr/local/bin
#RUN chmod a+x /usr/local/bin/shell.sh
#RUN /usr/local/bin/shell.sh $user $group
#
#RUN chown -R $USER:$GROUP /var/cache/nginx && \
#        chown -R $USER:$GROUP /var/log/nginx && \
#        chown -R $USER:$GROUP /etc/nginx && \
#        chown -R $USER:$GROUP /var/www
#RUN touch /var/run/nginx.pid && \
#        chown -R $USER:$GROUP /var/run/nginx.pid
#USER $USER


#RUN addgroup $GROUP && adduser -DH -G $GROUP $USER
#RUN apk add shadow && usermod -u $USER_ID $USER && groupmod -g $GROUP_ID $GROUP
#RUN mkdir ../../var/www
