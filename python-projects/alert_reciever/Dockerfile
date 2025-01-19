# base image of python with OS debian slim (meaning small one)
FROM python:3.12-slim

# set the working directory in the container
WORKDIR /app

# copy the dependencies file to the working directory
ADD . /app

# install dependencies
RUN pip install -r requirements.txt

# command to run on container start
ENTRYPOINT ["python", "alert.py"]