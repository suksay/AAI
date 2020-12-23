
docker build -t onap/test:latest .
docker run -d --name aai -p 0.0.0.0:8447:8447 onap/test:latest
apk add --update nodejs npm
apk add --update npm
npm install -g newman
newman run test_collection.json
