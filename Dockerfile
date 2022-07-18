FROM cloudera/quickstart:latest

# Install wget and java 8
RUN yum -y install wget java-1.8.0-openjdk ; yum clean all



#Fixing CentOS OS 6 yum repositorties and mirrors
WORKDIR /etc/yum.repos.d/
RUN cp CentOS-Base.repo CentOS-Base.repo.old
RUN mkdir backup
RUN mv cloudera* backup
RUN sed -i 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/os\/\$basearch\//baseurl=http:\/\/archive.kernel.org\/centos-vault\/6.10\/os\/\$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/updates\/\$basearch\//baseurl=http:\/\/archive.kernel.org\/centos-vault\/6.10\/updates\/\$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
RUN sed -i 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/extras\/\$basearch\//baseurl=http:\/\/archive.kernel.org\/centos-vault\/6.10\/extras\/\$basearch\//g' /etc/yum.repos.d/CentOS-Base.repo
RUN yum -y install wget ; yum -y install wget java-1.8.0-openjdk ; yum clean all ; yum  -y install centos-release-scl

RUN sed -i 's/# baseurl=http:\/\/mirror.centos.org\/centos\/6\/sclo\/\$basearch\/sclo\//baseurl=http:\/\/archive.kernel.org\/centos-vault\/6.10\/sclo\/\$basearch\/sclo\//g' /etc/yum.repos.d/CentOS-SCLo-scl.repo
RUN sed -i 's/#baseurl=http:\/\/mirror.centos.org\/centos\/6\/sclo\/\$basearch\/rh\//baseurl=http:\/\/archive.kernel.org\/centos-vault\/6.10\/sclo\/\$basearch\/rh\//g' /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo


#Python 3.6
RUN yum -y install centos-release-scl

RUN yum clean all ; yum -y update ; yum -y install rh-python36
RUN ln -fs /opt/rh/rh-python36/root/usr/bin/python /usr/bin/python


#Upgrade to Spark 2
WORKDIR /opt

RUN wget https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.6.tgz
RUN tar xf spark-2.4.4-bin-hadoop2.6.tgz
RUN mv spark-2.4.4-bin-hadoop2.6 spark
RUN mv /usr/lib/spark/ /tmp/spark
RUN ln -s /opt/spark /usr/lib/spark
RUN cp /tmp/spark/conf/spark-env.sh /opt/spark/conf/
RUN cp /opt/spark/conf/log4j.properties.template /opt/spark/conf/log4j.properties
RUN sed -i 's/\/etc\/hadoop\/conf\}/\/etc\/hadoop\/conf\}:\/etc\/hadoop\/conf:\/etc\/hive\/conf/g' /opt/spark/conf/spark-env.sh
RUN sed -i '1i export JAVA_HOME=\/usr\/lib\/jvm\/jre-1.8.0-openjdk.x86_64' /usr/lib/bigtop-utils/bigtop-detect-javahome
RUN sed -i 's/rootCategory\=INFO/rootCategory\=WARN/g' /opt/spark/conf/log4j.properties
RUN sed -i 's/lib\/spark-assembly-\*.jar/jars\/spark-hive\*jar/g' /usr/lib/hive/bin/hive
RUN cp /usr/bin/spark-shell /usr/bin/spark-sql
RUN sed -i 's/spark-shell/spark-sql/g' /usr/bin/spark-sql

# Enable historyserver logs
RUN sed -i 's/0.0.0.0:10020/quickstart.cloudera:10020/g' /etc/hadoop/conf/mapred-site.xml
RUN sed -i 's/0.0.0.0:19888/quickstart.cloudera:19888/g' /etc/hadoop/conf/mapred-site.xml
RUN sed -i 's/<\/configuration>/<property><name>yarn.log.server.url<\/name><value>http:\/\/quickstart.cloudera:19888\/jobhistory\/logs<\/value><\/property><\/configuration>/g' /etc/hadoop/conf/yarn-site.xml


WORKDIR /home/cloudera

