# cloudera-spark2-kerberos
Docker image for Cloudera and Spark 2.4.4

Add the following line to your laptop's `/etc/hosts` file:
`quickstart.cloudera	127.0.0.1`

For the image to be used, you have two options:
* Build the image by following these steps:
  * git clone [cloudera-spark2-kerberos](https://github.com/mikelemikelo/cloudera-spark2-kerberos.git)
  * `cd cloudera-spark2-kerberos`
  * `docker build -t mikelemikelo/cloudera-spark2-kerberos:latest .`
* Pull down the image from DockerHub ( Option not available yet )
  * `docker pull mikelemikelo/cloudera-spark2-kerberos:latest`
  


Start the image with:
@Blagica - pls confirm that we are not missing ports,  and remove comment after pls

```
sudo docker run --hostname=quickstart.cloudera --privileged=true -t -i -v /Users/miguelr/clouderacontainers:/src -m 12G -p 8180:8080 -p 19888:19888 -p 80:80 -p 8888:8888 -p 50070:50070 -p 50010:50010 -p 1004:1004 -p 8042:8042 -p 1006:1006 -p 7180:7180 -p 8020:8020 -p 8032:8032 -p 8990:8990 -p 21050:21050 -p 88:88 -p 88:88/udp cloudera/quickstart /usr/bin/docker-quickstart
```


**Start cloudera Manager Services:**
```
sudo /home/cloudera/cloudera-manager --express --force
sudo service cloudera-scm-server restart
service ntpd status
service ntpd start
```

Come back to cloudera manager http://0.0.0.0:7180/  and you should see Hosts icon is green(OK), but all other service seems not started, so we should click restart button like below to restart all service



## Kerberos set up

Execute:

`/home/cloudera/kerberos`


Follow the next guide [Cloudera + Kerberos ](https://chrisyen8341.medium.com/simple-way-to-setup-hadoop-single-node-cluster-with-kerberos-enable-from-docker-1dc0d9803c08) starting on step 8 

