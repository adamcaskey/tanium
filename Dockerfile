FROM centos/systemd
ENV FileHost="10.0.20.211"
ENV TaniumPubFile="https://${FileHost}/tanium.pub"
ENV TaniumRPMFile="https://${FileHost}/TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm"
RUN curl -k -o /tmp/taniumclient.rpm -L "${TaniumRPMFile}" && rpm -i /tmp/taniumclient.rpm && yum clean all && curl -k -o /opt/Tanium/TaniumClient/tanium.pub -L "${TaniumPubFile}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList tanium-client-1.caskey.co,tanium-client-2.caskey.co,tanium-client-z.caskey.co;
RUN /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel 71;
RUN systemctl enable taniumclient.service;
CMD systemctl start taniumclient.service && sleep 5 && tail -f /opt/Tanium/TaniumClient/Logs/log0.txt
