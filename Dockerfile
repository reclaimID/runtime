FROM schanzen/gnunet:experimental

EXPOSE 7777

COPY setup_reclaim.sh /opt

COPY --from=0 /opt /usr/

CMD [ "/opt/setup_reclaim.sh" ]

