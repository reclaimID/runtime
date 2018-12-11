FROM registry.gitlab.com/reclaimid/gnunet-docker:latest

EXPOSE 7777

COPY setup_reclaim.sh /opt

CMD [ "/opt/setup_reclaim.sh" ]

