FROM python:3.7-alpine
MAINTAINER Tim Cronshaw

# Run python in unbuffered mode (recommended in containers)
ENV PYTHONUNBUFFERED 1

# Pip install all requirements
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
# add temp dependencies
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r requirements.txt
# remove temp dependencies
RUN apk del .tmp-build-deps


# Create /app folder, cd into /app, and copy source code into /app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create and use basic non-root user for security purposes
RUN adduser -D user
USER user
