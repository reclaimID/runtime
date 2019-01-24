FROM registry.gitlab.com/reclaimid/gnunet-docker:experimental

EXPOSE 7777

COPY target/ /bin

CMD [ "setup_reclaim" ]

