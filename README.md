# Logstash config part of MEP - MISP Enrichment Pipeline

Here is the MEP system architecture:
![MEP Architecture](/assets/images/mep-diagram.png)


## Pipeline structure
In general the model gets data from [Beats](https://www.elastic.co/beats/) and it "feeds" two other pipelines that of them one sends the data straight to Elasticsearch and the other does the enrichment if a malicious IP was found. The last pipeline runs in parallel with the other 3, it just send Https cals to MISP local server in order to fetch new IoCs that are related with the bad IPs. So in general there are 4 pipelines running, as there are 4 *.conf* files in the *pipelines* folder.

## Notes
1. If you are using SSL configuration, either on Elsticseach or MISP local server, don't forget to add the certificates into the */config* folder. There ara sample files just for indication.
2. This config and pipeline files are meant to be used as a bind volume for docker logstash image. The command to run it is: ```docker run --rm --network="host" -d -v /your-repo-path/pipeline/:/usr/share/logstash/pipeline/ -v /your-repo-path/config/:/usr/share/logstash/config/ docker.elastic.co/logstash/logstash:7.13.0```. So it is very important to note that **the paths for pipeline or config files are all under the */usr/share/logstash/*** in the docker container. If you **plan to use logstash as a normal service change the paths accordingly**.
3. In the *pipelines/misp.conf* pipeline config file, don't forget to add your MISP Api key.