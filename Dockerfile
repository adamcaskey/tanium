FROM centos/systemd
COPY tanium.pub /
COPY TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm /
RUN rpm -i taniumclient.rpm; yum clean all;
COPY tanium.pub /opt/Tanium/TaniumClient
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList tanium-client-1.caskey.co,tanium-client-2.caskey.co,tanium-client-z.caskey.co;
RUN systemctl enable taniumclient.service
CMD ["/usr/sbin/init"]
