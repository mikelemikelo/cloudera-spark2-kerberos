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

```
```


**Start cloudera Manager Services:**
```
sudo /home/cloudera/cloudera-manager --express --force
sudo service cloudera-scm-server restart
service ntpd status
service ntpd start
```

Come back to cloudera manager http://0.0.0.0:7180/  and you should see Hosts icon is green(OK), but all other service seems not started, so we should click restart button like below to restart all service

