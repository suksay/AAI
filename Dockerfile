FROM onap/aai-resources:1.7.2

COPY DbEdgeRules_v20.json /opt/app/aai-resources/resources/schema/onap/dbedgerules/v20/DbEdgeRules_v20.json
#COPY aai_oxm_v20.xml /opt/app/aai-resources/resources/schema/onap/oxm/v20/aai_oxm_v20.xml
#COPY aai_oxm_v16.xml /opt/app/aai-resources/resources/schema/onap/oxm/v20/aai_oxm_v16.xml
