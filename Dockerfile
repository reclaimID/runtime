FROM alpine:latest

RUN apk add --update vim wget alpine-sdk automake autoconf libtool libltdl flex bison gmp-dev libgcrypt-dev glib-dev libunistring-dev libidn-dev linux-headers jansson-dev libmicrohttpd-dev gnutls-dev sqlite-dev libidn-dev && rm -rf /var/cache/apk/* /tmp/*

WORKDIR /opt

RUN wget -q https://ftp.gnu.org/gnu/gnunet/gnurl-7_52_1.tar.bz2 -O gnurl.tar.bz2 && mkdir gnurl && tar xvf gnurl.tar.bz2 -C gnurl --strip-components 1 && cd gnurl && autoreconf -i && ./configure --prefix=/opt --disable-ntlm-wb --with-gnutls && make install && rm -rf /opt/gnurl*

RUN wget -q https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz && tar xvzpf pbc-0.5.14.tar.gz && cd pbc-0.5.14 && ./configure --prefix=/opt && make install && rm -rf /opt/pbc*

RUN git clone https://github.com/schanzen/libgabe.git && cd /opt/libgabe && ./configure --prefix=/opt --with-pbc-include=/opt/include --with-pbc-lib=/opt/lib && make install && rm -rf /opt/libgabe*

RUN wget -q ftp://ftp.gnu.org/gnu/libextractor/libextractor-1.7.tar.gz && tar xvzpf libextractor-1.7.tar.gz && cd libextractor-1.7 && ./configure --prefix=/opt && make install && rm -rf /opt/libextractor*

RUN wget -q ftp://ftp.gnu.org/gnu/glpk/glpk-4.55.tar.gz && tar xvzpf glpk-4.55.tar.gz && cd glpk-4.55 && ./configure --prefix=/opt && make install && rm -rf /opt/glpk-4.55*

RUN cp -r /opt/* /usr

RUN git clone git://gnunet.org/gnunet.git && cd gnunet && ./bootstrap && ./configure --help && ./configure --enable-experimental --prefix=/opt --disable-documentation --with-microhttpd --with-extractor=/opt --with-libgnurl=/opt && make && make install && rm -rf /opt/gnunet/

RUN cp /usr/bin/xxd /opt/bin/

FROM alpine:latest

WORKDIR /opt

RUN apk add --update openssl libbz2 libtool libltdl libunistring libidn jansson libmicrohttpd gnutls sqlite-dev glib libgcrypt gmp flex bison && rm -rf /var/cache/apk/* /tmp/*

EXPOSE 7777

COPY setup_reclaim.sh /opt

COPY --from=0 /opt/* /usr

CMD [ "/opt/setup_reclaim.sh" ]

