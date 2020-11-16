# AAI Integration

The integration of AAI was done in several steps:
## Installation of AAI components 

  1. Create a docker-component allowing to have Janusgraph, Cassandra (3.11) and aai-resource (version 1.7.2) services.

Janusgraph : A&AI uses Janusgraph for persistence which is a property graphmodel, where a graph is a set of vertices with edges between them. JanusGraph stores graphs in adjacency list format which means that a
graph is stored as a collection of vertices with their adjacency list.

Cassandra : Apache Cassandra is a highly-scalable partitioned row store. Rows are organized into tables with a required primary key. Janusgraph use Cassandra like a storage backend.

aai-resource : AAI Resources Micro Service providing CRUD REST APIs for inventory resources. This microservice provides the main path for updating and searching the graph - java-types defined in the OXM file for each version of the API define the REST endpoints.



```
#####  We create a 'storage_network' for storage block elements

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
        - "8447:8447" #Port use to send REST resquest to AAI Resources container
    networks:
        - cds_network
        - storage_network    

janusgraph:
    image: janusgraph/janusgraph:latest
    container_name: jce-janusgraph
    environment:
        JANUS_PROPS_TEMPLATE: cassandra-es
        janusgraph.storage.backend: cql #We specify that we use a cassandra backend 
        janusgraph.storage.hostname: jce-cassandra   #We specify cassandra's container address to Janusgraph
        #janusgraph.index.search.hostname: jce-elastic
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
        - "CASSANDRA_START_RPC=true" 
    ports:    #9042 and 9160 are use to comunique with AAi-resources and Janusgraph
        - "9042:9042" 
        - "9160:9160"
    networks:
        - storage_network
```

  2. Configure aai-resources through the janusgraph-*.properties files so that it can store data in Cassandra.

  In the aai-resources container, we have to configure the files allowing it to store the data in Cassandra. We chose to do this when we created the container. 

  Setp 1 : We pre-configure the janusgraph-cached.properties and janusgraph-cached.properties files locally with the information from Cassandra.

```
#The following parameters are not reloaded automatically and require a manual bounce
storage.backend=cql   #Cassandra like storage backend 
storage.hostname=jce-cassandra #Cassandra address according to cassandra container name
storage.cql.keyspace=onap #Keyspace for our databse in Cassandra
```

   Step 2: They are copied into the aai-resources container during its creation with spcefical Dockerfile called aai_resources_init

```
#AAI Resources initialisation with cassandra properties

FROM onap/aai-resources:1.7.2

COPY janusgraph-cached.properties /opt/app/aai-resources/resources/etc/appprops/janusgraph-cached.properties
COPY janusgraph-realtime.properties /opt/app/aai-resources/resources/etc/appprops/janusgraph-realtime.properties
```

## CDS and AAI connection

    - Add the BluePrint Processor and Command Executor services on the same network as the aai-resources service to be able to execute REST requests on Cassandra via aai-resoruces.

## Creation of Microwaves models

    - To be able to store our equipment, we must first create models of our equipment in AAI. We create the main model for all the microwaves equipments (PUT /service-design-and-creation/models/model/microwave-equipment-id) then the specific Huawei and NEC models (PUT /service-design-and-creation/models/model/{model-invariant-id}/model-ver/{nec or huawei id}).

    - Once the models are created, we can register our equipment in /network/devices. 
