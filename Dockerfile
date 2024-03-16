# pull python base image
FROM python:3.10

# specify working directory
WORKDIR /titanic_model_api

ADD /titanic_model_api/requirements.txt .
ADD /titanic_model_api/*.whl .

# update pip
RUN pip install --upgrade pip

# install dependencies
RUN pip install -r requirements.txt

RUN rm *.whl

# create a user
RUN useradd -m -u 1000 myuser

# switch user to myuser
USER myuser

# copy application files & change/give ownership to myuser
COPY --chown=myuser /titanic_model_api/app/. /titanic_model_api/app/.
COPY --chown=myuser /titanic_model_api/flagged/. /titanic_model_api/flagged/.

# expose port for application
EXPOSE 8001

# start fastapi application
CMD ["python", "app/main.py"]
