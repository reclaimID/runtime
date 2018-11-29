FROM schanzen/gnunet:experimental

WORKDIR /opt

EXPOSE 7777

COPY setup_reclaim.sh /opt

CMD [ "/opt/setup_reclaim.sh" ]

