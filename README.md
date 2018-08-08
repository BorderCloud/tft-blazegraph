[![Build Status](https://travis-ci.org/BorderCloud/tft-blazegraph.svg)](https://travis-ci.org/BorderCloud/tft-blazegraph)

# tft-blazegraph: Blazegraph 

## Calculate SparqlScore with TFT in local

### Install
```
# Download docker's images 
docker pull bordercloud/tft-jena-fuseki
docker pull bordercloud/tft-virtuoso7-stable

# Compile the docker's project 
docker build -t tft-blazegraph .
  
# Deploy network of SPARQL services

# 172.17.0.2
docker run --privileged --name instance.tft-blazegraph -h tft-blazegraph -d tft-blazegraph
# 172.17.0.3
docker run --privileged --name instance.tft.example.org -h example.org -d bordercloud/tft-virtuoso7-stable
# 172.17.0.4
docker run --privileged --name instance.tft.example1.org -h example1.org -d bordercloud/tft-virtuoso7-stable
# 172.17.0.5
docker run --privileged --name instance.tft.example2.org -h example2.org -d bordercloud/tft-virtuoso7-stable
# 172.17.0.6 for local
docker run --privileged --name instance.tft_database -d bordercloud/tft-jena-fuseki

# docker network inspect bridge

git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT

# install SPARQL client
composer install 
```

### Start tests
Add parameter debug if necessary '-d'
```
php ./tft-testsuite -a -t fuseki -q http://172.17.0.6/test/query \
                    -u http://172.17.0.6/test/update
                    
php ./tft -t fuseki -q http://172.17.0.6/test/query \
                    -u http://172.17.0.6/test/update \
          -tt fuseki -tq http://172.17.0.2/blazegraph/namespace/test/sparql/ \
                     -tu http://172.17.0.2/blazegraph/namespace/test/sparql/ \
          -r http://example.org/buildid   \
          -o ./junit  \
          --softwareName="blazegraph" \
          --softwareDescribeTag=X.X.X \
          --softwareDescribe="Name"
                    
php ./tft-score -t fuseki -q http://172.17.0.6/test/query 
                          -u http://172.17.0.6/test/update 
                -r  http://example.org/buildid
```
blazegraph's endpoint is near of Fuseki.

# Delete containers of TFT

```
docker stop instance.tft_database
docker rm instance.tft_database
docker stop instance.tft.example.org
docker rm instance.tft.example.org
docker stop instance.tft.example1.org
docker rm instance.tft.example1.org
docker stop instance.tft.example2.org
docker rm instance.tft.example2.org
docker stop instance.tft-blazegraph
docker rm instance.tft-blazegraph

```

# Delete all containers

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```
