[![Build Status](https://travis-ci.org/BorderCloud/tft-blazegraph.svg)](https://travis-ci.org/BorderCloud/tft-blazegraph)

# tft-blazegraph: Blazegraph 

## Calculate SparqlScore with TFT in local

### Install
```
# Compile the docker's project 
docker build --build-arg branch_blazegraph=BLAZEGRAPH_RELEASE_2_1_5 -t tft-blazegraph .
#docker build --build-arg branch_blazegraph=BLAZEGRAPH_2_1_6_RC -t tft-blazegraph .
#docker build --build-arg branch_blazegraph=BLAZEGRAPH_RELEASE_CANDIDATE_2_2_0 -t tft-blazegraph .
  
# Deploy network of SPARQL services

docker-compose up -d 
# docker-compose stop

git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT

# install SPARQL client
composer install 

# install JMeter for protocol tests
wget http://mirrors.standaloneinstaller.com/apache//jmeter/binaries/apache-jmeter-5.4.1.tgz
tar xvzf apache-jmeter-5.4.1.tgz 
mv  apache-jmeter-5.4.1 jmeter
rm apache-jmeter-5.4.1.tgz 
```

### Start tests
Add parameter debug if necessary '-d'
```
php ./tft-testsuite -a -t fuseki -q http://172.18.0.6:8080/test/query \
                    -u http://172.18.0.6:8080/test/update

php ./tft -t fuseki -q http://172.18.0.6:8080/test/query \
                    -u http://172.18.0.6:8080/test/update \
          -tt fuseki -te http://172.18.0.2/blazegraph/namespace/test/sparql \
          -r http://example.org/buildid   \
          -o ./junit  \
          --softwareName="blazegraph" \
          --softwareDescribeTag=2.1.5 \
          --softwareDescribe="Name"
        
php ./tft-score -t fuseki -q http://172.18.0.6:8080/test/query \
                          -u http://172.18.0.6:8080/test/update \
                -r  http://example.org/buildid  
```
blazegraph's endpoint is near of Jena Fuseki.

# Delete containers of TFT

```
docker stop instance.tft-database
docker rm instance.tft-database
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
