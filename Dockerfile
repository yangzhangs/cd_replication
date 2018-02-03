#cd replication docker image
FROM ubuntu:latest
COPY /Data /tmp/cd_data/
COPY /Models /tmp/cd_models/
COPY /Survey /tmp/cd_survey/
COPY README.md /tmp/
