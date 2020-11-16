# AAI Integration

The integration of AAI was done in several steps:
1. Installation of AAI components :
    - Create a docker-component allowing to have Janusgraph, Cassandra (3.11) and aai-resource (version 1.7.2) services.

Janusgraph : A&AI uses Janusgraph for persistence which is a property graphmodel, where a graph is a set of vertices with edges between them. JanusGraph stores graphs in adjacency list format which means that a
graph is stored as a collection of vertices with their adjacency list.

Cassandra : Apache Cassandra is a highly-scalable partitioned row store. Rows are organized into tables with a required primary key. Janusgraph use Cassandra like a storage backend.

aai-resource : AAI Resources Micro Service providing CRUD REST APIs for inventory resources. This microservice provides the main path for updating and searching the graph - java-types defined in the OXM file for each version of the API define the REST endpoints.

```
 #AAI Resources
    aai-resources:
        #Change janusgrap properties files in aai-resource with cassandra hostname
        build:
           context: .
           dockerfile: aai_resources_init
        container_name: aai-resources
        #depends_on: 
        #    - jce-cassandra
        ports:
            - "8447:8447"
        networks:
            - cds_network
            - storage_network    
    
    janusgraph:
        image: janusgraph/janusgraph:latest
        container_name: jce-janusgraph
        environment:
            JANUS_PROPS_TEMPLATE: cassandra-es
            janusgraph.storage.backend: cql
            janusgraph.storage.hostname: jce-cassandra
            janusgraph.index.search.hostname: jce-elastic
        ports:
            - "8182:8182"
        healthcheck:
            test: ["CMD", "bin/gremlin.sh", "-e", "scripts/remote-connect.groovy"]
            interval: 10s
            timeout: 30s
            retries: 3
        networks:
            - storage_network
    
    #Cassandra
    cassandra:
        image: cassandra:3.11
        container_name: jce-cassandra
        environment:
            #HEAP_NEWSIZE: 1M
            #MAX_HEAP_SIZE: 1024M
            - "CASSANDRA_START_RPC=true"
        ports:
            - "9042:9042"
            - "9160:9160"
        networks:
            - storage_network
```

    - Configure Janusgraph so that it can connect to Cassandra. 

    - Configure aai-resources through the janusgraph-*.properties files so that it can store data in Cassandra.

2. CDS and AAI connection

    - Add the BluePrint Processor and Command Executor services on the same network as the aai-resources service to be able to execute REST requests on Cassandra via aai-resoruces.

3. Creation of Microwaves models

    - To be able to store our equipment, we must first create models of our equipment in AAI. We create the main model for all the microwaves equipments (PUT /service-design-and-creation/models/model/microwave-equipment-id) then the specific Huawei and NEC models (PUT /service-design-and-creation/models/model/{model-invariant-id}/model-ver/{nec or huawei id}).

    - Once the models are created, we can register our equipment in /network/devices. 
