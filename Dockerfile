# Start from a standard Ubuntu image
FROM ubuntu:18.04

# Metadata
LABEL maintainer="Philip R. Jarnhus <https://www.github.com/pjarnhus>"

# Environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Update the standard Ubuntu image with relevant 
RUN apt-get update --fix-missing && apt-get install -y \
    build-essential \
    git-core \
    pkg-config \
    python3-dev \
    python3-pip \
    python-setuptools \
    vim \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt-get/lists/*

# Install relevant python packages
RUN pip3 --no-cache-dir install --upgrade \
    jupyter \
    matplotlib \
    numpy \
    pandas

# Open up ports for Jupyter
EXPOSE 7745 

# Create a project directory in the container
RUN mkdir ds

# Set bash as the default shell
ENV SHELL=/bin/bash

# Set the project directory up for being linked to a dir on the system
VOLUME /ds

# Change workdir to the project dir
WORKDIR /ds

# Add the shell script for running the Jupyter server
ADD run_jupyter.sh /bin/run_jupyter.sh

# Make the shell script runable
RUN chmod a+x /bin/run_jupyter.sh

# Run the shell command to start the Jupyter server
CMD ["/bin/run_jupyter.sh"]
