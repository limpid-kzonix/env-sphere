# Docker miscellaneous utils

### Jenkins Slave JNLP Docker Agent (amd64)

```docker pull limpidkzonix/jenkins-jnlp-slave```

```
  docker run limpidkzonix/jenkins-jnlp-slave:arm -workDir=/home/jenkins/agent \
   -url $SERVER_URL $SECRET $AGENT_NAME \
   -disableHttpsCertValidation
```

[Jenkins JNLP Agent Docker image for ARM64](https://hub.docker.com/r/limpidkzonix/jenkins-jnlp-slave)
