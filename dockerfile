FROM python:3.9

# Allow statements and log messages to immediately appear in the Cloud Run logs
ENV PYTHONUNBUFFERED True

# Copy application dependency manifests to the container image.
# Copying this separately prevents re-running pip install on every code change.
COPY requirements.txt ./

# Install production dependencies.
RUN pip install -r requirements.txt

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app


# FROM python:3.9-slim
# # WORKDIR /app
# # ADD . /app
# ENV PYTHONUNBUFFERED True
# # Copy local code to the container image.
# ENV APP_HOME /app
# WORKDIR $APP_HOME
# COPY . ./
# RUN pip install -r requirements.txt

# CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app



#budiling container image on gcp
#gcloud builds --project sada-u-sess-3-firestore \                           
    #submit --tag gcr.io/sada-u-sess-3-firestore/flask-app:v1 .

#builing cloud run to test before k8
#gcloud run deploy --image gcr.io/sada-u-sess-3-firestore/flask-app:v1
# FROM python:3.9-slim

# # WORKDIR /app
# # ADD . /app
# # ADD requirements.txt /app/requirements.txt
# # RUN pip install -r /app/requirements.txt

# WORKDIR /app
# ADD . /app
# RUN pip install -r requirements.txt
#https://knative.dev/docs/serving/samples/hello-world/helloworld-python/