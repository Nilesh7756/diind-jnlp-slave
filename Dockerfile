FROM java:8u66-jdk

ENV JENKINS_REMOTING_VERSION 2.52
ENV HOME /home/jenkins

RUN useradd -c "Jenkins user" -d $HOME -m jenkins && groupadd docker && gpasswd -a jenkins docker

RUN curl --create-dirs -sSLo /usr/share/jenkins/remoting-$JENKINS_REMOTING_VERSION.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar \
  && chmod 755 /usr/share/jenkins

COPY docker/* /usr/local/bin/

USER jenkins

VOLUME /home/jenkins

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
