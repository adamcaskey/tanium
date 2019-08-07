FROM centos/systemd

ARG FileHost="10.0.20.211"
ARG TaniumPubFile="https://${FileHost}/tanium.pub"
ARG TaniumRPMFile="https://${FileHost}/TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm"
ARG ServerNameList="tanium-client-1.caskey.co,tanium-client-2.caskey.co,tanium-client-z.caskey.co"
ARG LogVerbosityLevel="1"

ENV FileHost=${FileHost}
ENV TaniumPubFile=${TaniumPubFile}
ENV TaniumRPMFile=${TaniumRPMFile}
ENV ServerNameList=${ServerNameList}
ENV LogVerbosityLevel=${LogVerbosityLevel}

RUN curl -k -o /tmp/taniumclient.rpm -L "${TaniumRPMFile}" && rpm -i /tmp/taniumclient.rpm && yum clean all && curl -k -o /opt/Tanium/TaniumClient/tanium.pub -L "${TaniumPubFile}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList "${ServerNameList}";
RUN /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel "${LogVerbosityLevel}";
RUN systemctl enable taniumclient.service;

EXPOSE 17472

CMD /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList "${ServerNameList}";
CMD /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel "${LogVerbosityLevel}";
CMD /opt/Tanium/TaniumClient/TaniumClient && sleep 5 && tail -f /opt/Tanium/TaniumClient/Logs/log0.txt
