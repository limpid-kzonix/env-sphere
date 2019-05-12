#!/bin/bash

docker run limpidkzonix/jenkins-jnlp-slave:arm -workDir=/home/jenkins/agent \
 -url http://192.168.0.101:8880 961f59fff6521797bff8087e680f03488b1ae4224fb299cefe88052874ada189 jeremejevite \
 -disableHttpsCertValidation