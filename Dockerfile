FROM centos/systemd
ENV FileHost="10.0.20.211"
ENV TaniumPubFile="https://${FileHost}/tanium.pub"
ENV TaniumRPMFile="https://${FileHost}/TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm"
ENV ServerNameList="tanium-client-1.caskey.co,tanium-client-2.caskey.co,tanium-client-z.caskey.co"
ENV LogVerbosityLevel='1'
RUN curl -k -o /tmp/taniumclient.rpm -L "${TaniumRPMFile}" && rpm -i /tmp/taniumclient.rpm && yum clean all && curl -k -o /opt/Tanium/TaniumClient/tanium.pub -L "${TaniumPubFile}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList "${ServerNameList}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel "${LogVerbosityLevel}";
RUN systemctl enable taniumclient.service;
EXPOSE 17472
CMD /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList "${ServerNameList}";
CMD /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel "${LogVerbosityLevel}";
CMD /opt/Tanium/TaniumClient/TaniumClient && sleep 5 && tail -f /opt/Tanium/TaniumClient/Logs/log0.txt
