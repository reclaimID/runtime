FROM registry.gitlab.com/reclaimid/gnunet-docker:experimental

EXPOSE 7777

COPY setup_reclaim.sh /opt
COPY create_client /bin

CMD [ "/opt/setup_reclaim.sh" ]

