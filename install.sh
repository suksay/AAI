export AAI_ADDRESS="localhost"
export AAI_USERNAME="AAI"
export AAI_PASSWORD="AAI"

#Create complexe device
curl -k --user AAI:AAI --request PUT 'https://localhost:8447/aai/v19/network/devices/device/test2' \
--header 'X-TransactionId: 999' \
--header 'X-FromAppId: AAI' \
--header 'Authorization: Basic QUFJOkFBSQ==' \
--header 'depth: all' \
--header 'Content-Type: application/json' \
--data-raw '{
    "device-id" : "test2",
    "device-name" : "test-device-name",
    "vendor" : "test-vendor",
    "system-ip" : "test-system-ip3",
    "system-ipv4" : "test-system-ipv4",
    "description" : "We use model-customization-id for NE ID "
}'

#Add qinq
curl -k --user AAI:AAI --location --request PUT 'https://localhost:8447/aai/v19/network/devices/device/test2/qinq-links/qinq-link/link1' \
--header 'X-TransactionId: 999' \
--header 'X-FromAppId: AAI' \
--header 'Authorization: Basic QUFJOkFBSQ==' \
--header 'depth: all' \
--header 'Content-Type: application/json' \
--data-raw '{
    "qinq-link-id": link1,
    "port-name": "example-port-name",
    "qinq-vlan-id": "de",
    "status": "example-status-val-47719",
  
}' 


#Add uni-2-uni
curl -k --user AAI:AAI --location --request PUT 'https://localhost:8447/aai/v19/network/devices/device/test2/uni-2-unis/uni2-uni/link2' \
--header 'X-TransactionId: 999' \
--header 'X-FromAppId: AAI' \
--header 'Authorization: Basic QUFJOkFBSQ==' \
--header 'depth: all' \
--header 'Content-Type: application/json' \
--data-raw '{
    "link-id": "link2",
    "nms-index": "example-nms-index-val-44991",
    "link-name": "example-link-name-val-35245",
    "port-a": "example-port-a-val-88059",
    "vlan-list-a": [
        "example-vlan-list-a-val-91624-1",
        "example-vlan-list-a-val-74376-2"
    ],
    "port-b": "example-port-b-val-2399",
    "vlan-list-b": [
        "example-vlan-list-b-val-70593-1",
        "example-vlan-list-b-val-43050-2"
    ],
    "status": "example-status-val-47977"
}' 


#Add uni-2-nni

curl -k --user AAI:AAI --location --request PUT 'https://localhost:8447/aai/v19/network/devices/device/test2/uni-2-nnis/uni2-nni/test-uni-2-nni' \
--header 'X-TransactionId: 999' \
--header 'X-FromAppId: AAI' \
--header 'Authorization: Basic QUFJOkFBSQ==' \
--header 'depth: all' \
--header 'Content-Type: application/json' \
--data-raw '{
  "link-id": "test-uni-2-nni",
  "nms-index": "example-nms-index-val-67852",
  "name": "example-name-val-18571",
  "port": "example-port-val-15452",
  "qinq-link-id": "fzfzzffgrgr",
  "vlan-list": [
    "example-vlan-list-val-9557-1",
    "example-vlan-list-val-15262-2"
  ],
 
  "status": "example-status-val-46550"
}' 


#Add nni-2-nni
curl -k --user AAI:AAI --location --request PUT 'https://localhost:8447/aai/v19/network/devices/device/test2/nni-2-nnis/nni2-nni/example-link-id-val-74852' \
--header 'X-TransactionId: 999' \
--header 'X-FromAppId: AAI' \
--header 'Authorization: Basic QUFJOkFBSQ==' \
--header 'depth: all' \
--header 'Content-Type: application/json' \
--data-raw '{
  "link-id": "example-link-id-val-74852",
  "nms-index": "example-nms-index-val-43738",
  "link-name": "example-link-name-val-40447",
  "qinq-link-id-a": "example-qinq-link-id-a-val-7397",
  "qinq-link-id-b": "example-qinq-link-id-b-val-73099",
  "status": "example-status-val-87289"
}'


curl --verbose -k --silent --insecure --user AAI:AAI --header "Accept: application/json" --header "X-TransactionId: testaai" --header "Content-Type: application/json" --header "X-FromAppId: AAI2" https://localhost:8447/aai/v19/network/devices/device/test2?depth=all | jq '.'
