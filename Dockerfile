FROM centos/systemd
ENV TaniumPubFile="https://10.0.20.211/tanium.pub"
ENV TaniumRPMFile="https://10.0.20.211/TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm"
RUN curl -k -o /tmp/taniumclient.rpm -L "${TaniumRPMFile}" && rpm -i /tmp/taniumclient.rpm && yum clean all && curl -k -o /opt/Tanium/TaniumClient/tanium.pub -L "${TaniumPubFile}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList 10.0.20.211,10.0.20.212,10.0.30.314;
RUN systemctl enable taniumclient.service
CMD ["/usr/sbin/init"]
