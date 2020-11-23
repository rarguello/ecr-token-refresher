FROM amazon/aws-cli

MAINTAINER Ricardo Arguello <ricardo.arguello@gmail.com>

LABEL name="ecr-token-refresher" \
      architecture="x86_64" \
      io.k8s.display-name="ECR Token Refresher" \
      io.k8s.description="Amazon ECR registry token refresher" \
      io.openshift.tags="openshift,aws,ecr"

RUN curl -sO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
    yum -y install tar gzip && \
    tar xzf openshift-client-linux.tar.gz -C /usr/local/bin && \
    rm openshift-client-linux.tar.gz /usr/local/bin/README.md && \
    yum -y remove tar gzip && \
    yum clean all && \
    chmod g+w /aws

COPY scripts/ecr-token-refresher.sh /usr/local/bin

ENTRYPOINT []
RUN chmod 755 /usr/local/bin/ecr-token-refresher.sh

USER 1001
CMD ["ecr-token-refresher.sh"]
