FROM ghcr.io/runatlantis/atlantis:dev-debian-bab1b59

ARG WORK_DIR="/app/"
USER root
WORKDIR ${WORK_DIR}

ARG TG_VERSION="0.68.12"

ENV ATLANTIS_TF_DOWNLOAD="false"
ENV TERRAGRUNT_TFPATH="/usr/local/bin/tofu"

RUN apt update \
    && apt install -y wget

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt

COPY repos.yaml ${WORK_DIR}

RUN chown -R atlantis:atlantis ${WORK_DIR}

USER atlantis

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["server"]
