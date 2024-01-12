FROM  python:3.6-alpine 

# Setup flask application
RUN mkdir -p /deploy/app
#COPY gunicorn_config.py /deploy/gunicorn_config.py
COPY ./ /deploy/app
RUN pip install -r /deploy/app/requirements.txt  

WORKDIR /deploy/app/ui
ENV FLASK_APP=ui.py
ENV MONGO mongo
ENV MONGO_PORT 27017
EXPOSE 8000
# Start gunicorn
#CMD ["gunicorn", "--config", "/deploy/gunicorn_config.py", "ui:app"]
#CMD ["coverage", "run" ,"-m unittest discover", "-s tests/"]
#CMD ["flask", "run", "--host=0.0.0.0"]

CMD ["gunicorn", "ui:app", "-b", "0.0.0.0"]
