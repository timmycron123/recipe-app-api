FROM python:3.7-alpine
MAINTAINER Tim Cronshaw

# Run python in unbuffered mode (recommended in containers)
ENV PYTHONUNBUFFERED 1

# Pip install all requirements
COPY ./requirements.txt /requirements.txt
RUN pip install -r requirements.txt

# Create /app folder, cd into /app, and copy source code into /app
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create and use basic non-root user for security purposes
RUN adduser -D user
USER user
