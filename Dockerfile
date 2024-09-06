FROM ubuntu:24.04
WORKDIR /usr/src/app
RUN apt update && apt -y upgrade && \
    apt install -y build-essential libpcre3-dev libpam0g-dev libssl-dev libwrap0-dev libc6-dev libnsl-dev flex bison make wget systemd rsyslog
RUN wget https://shrubbery.net/pub/tac_plus/tacacs-F4.0.4.28.tar.gz && \
    tar -xvzf tacacs-F4.0.4.28.tar.gz && \
    cd tacacs-F4.0.4.28 && \
    ./configure && \
    make && \
    make install && \
    ldconfig /usr/local/lib/
COPY ./tac_plus.conf /etc/tac_plus.conf
EXPOSE 49

RUN echo '#!/bin/bash\n\
/usr/local/sbin/tac_plus -C /etc/tac_plus.conf -d 16 &\n\
echo "TACACS+ server started in background"\n\
tail -f /dev/null' > /entrypoint.sh && chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
