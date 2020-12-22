FROM onap/aai-resources:1.7.2

COPY DbEdgeRules_Microwaves_v20.json /opt/app/aai-resources/resources/schema/onap/dbedgerules/v20/
COPY aai_oxm_v20.xml /opt/app/aai-resources/resources/schema/onap/oxm/v20
