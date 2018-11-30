FROM schanzen/gnunet:experimental

EXPOSE 7777

COPY setup_reclaim.sh /opt

CMD [ "/opt/setup_reclaim.sh" ]

