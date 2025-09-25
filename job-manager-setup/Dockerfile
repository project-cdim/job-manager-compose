FROM alpine:3.22

RUN apk update && \
    apk upgrade --available && \
    apk add --no-cache \
    curl

WORKDIR /home/job-manager-setup
COPY job-manager-setup/init.sh .
RUN chmod +x init.sh

COPY job-manager-setup/CDIM-project.zip .
COPY job-manager-setup/HW_configuration_information_data_linkage_job.yaml .
COPY job-manager-setup/Alert_manager_housekeeping_job.yaml .
COPY share/token/tokens.properties .

CMD ["./init.sh"]
