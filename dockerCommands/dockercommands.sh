# Docker commands to build the image
docker build -t flask-contacts-app .

# push the container to shashkist
docker tag flask-contacts-app shashkist/flask-contacts-app
docker push shashkist/flask-contacts-app

# optional you can specify the version 
# docker tag flask-contacts-app shashkist/flask-contacts-app:1.0
# docker push shashkist/flask-contacts-app:1.0

# Run the container
# this should include sql running on local machine or mongo
docker run -d -p 5052:5052 flask-contacts-app

# we would like to run it as a dockercompose
