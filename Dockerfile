FROM registry.gitlab.com/reclaimid/gnunet-docker:latest

RUN sed -i '/# ADD CUSTOM CONFIGURATION HERE #/ r demo_configuration' /opt/setup_reclaim.sh

CMD [ "/opt/setup_reclaim.sh" ]

