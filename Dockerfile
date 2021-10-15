FROM python:3.8.5-slim-buster

ARG AWSCLI_VERSION=1.19.98 

WORKDIR /app

COPY . .

RUN pip install awscli==$AWSCLI_VERSION && python setup.py install

ENTRYPOINT [ "aws-sso-cred-restore"]
