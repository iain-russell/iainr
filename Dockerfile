# image source
FROM python:3.7-alpine
# shows who maintains the app
MAINTAINER iain-russell

# tells python to write in unbuffered mode
# recommended for running python in docker
ENV PYTHONUNBUFFERED 1

# copies the local requirements.txt to the docker requirements.txt
COPY ./requirements.txt /requirements.txt
# installs postgresql-client in alpine
RUN apk add --update --no-cache postgresql-client jpeg-dev
# installs temporary postgres dependencies for postgres
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
# installs the requirements using pip
RUN pip install -r /requirements.txt
# deletes temporary requirements in alpine
RUN apk del .tmp-build-deps

# create a directory on docker image to store application source code
RUN mkdir /app
# makes /app the default working directory
WORKDIR /app
# copies local /app to docker image /app directory
COPY ./app /app


# Stores media in a shared folder outside of docker
RUN mkdir -p /vol/web/media
# Stores static in a shared folder outside of docker
RUN mkdir -p /vol/web/static
# create user that runs application using docker (user can be any name)
# for security reasons, stops any possible intruders from having root access
RUN adduser -D user
# sets ownership within /vol folder to user
RUN chown -R user:user /vol
# gives user privileges in /vol/web
RUN chmod -R 755 /vol/web
# switch to user ()
USER user
