[![Build Status](https://travis-ci.org/BorderCloud/tft-blazegraph.svg)](https://travis-ci.org/BorderCloud/tft-blazegraph)

# tft-blazegraph: Blazegraph 2.0.0

## Calculate SPARQLScore with tft in local


```
docker pull bordercloud/tft-jena-fuseki
docker pull bordercloud/tft-virtuoso7-stable

docker build -t tft-blazegraph .

docker run --privileged --name instance.tft-blazegraph -h tft-blazegraph -d tft-blazegraph
docker run --privileged --name instance.tft.example.org -h example.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example1.org -h example1.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft.example2.org -h example2.org -d bordercloud/tft-virtuoso7-stable
docker run --privileged --name instance.tft_database -d bordercloud/tft-jena-fuseki

#docker exec -it instance.tft-blazegraph /bin/bash


git clone --recursive https://github.com/BorderCloud/TFT.git
cd TFT
composer install
php ./tft-testsuite -a -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update
php ./tft -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -tt fuseki -tq http://172.17.0.6/blazegraph/namespace/test/sparql/ -tu http://172.17.0.6/blazegraph/namespace/test/sparql/ -r http://test.com/test -o ./junit --softwareName="blazegraph" --softwareDescribeTag="v2" --softwareDescribe="Blazegraph 2.0.0 release"
php ./tft-score -t fuseki -q http://172.17.0.2/test/query -u http://172.17.0.2/test/update -r http://test.com/test
```
## Clean

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
