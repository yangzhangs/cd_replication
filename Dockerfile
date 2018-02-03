#cd replication docker image
FROM ubuntu:latest
COPY /Data
COPY /Models
COPY /Survey
COPY README.md
