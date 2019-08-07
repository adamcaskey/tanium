FROM centos/systemd
ENV TaniumPubFile="https://ts1.caskey.co/tanium.pub"
ENV TaniumRPMFile="https://ts1.caskey.co/TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm"
RUN curl -k -s -o /tmp/taniumclient.rpm -L "${TaniumRPMFile}" && rpm -i /tmp/taniumclient.rpm && yum clean all && curl -k -s -o /opt/Tanium/TaniumClient/tanium.pub -L "${TaniumPubFile}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList tanium-client-1.caskey.co,tanium-client-2.caskey.co,tanium-client-z.caskey.co;
RUN systemctl enable taniumclient.service;
CMD /opt/Tanium/TaniumClient/TaniumClient && sleep 5 && tail -f /opt/Tanium/TaniumClient/Logs/log0.txt
