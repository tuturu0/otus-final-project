FROM  python:3.6-alpine 

COPY ./ /app
WORKDIR /app
RUN pip install -r requirements.txt
ENV EXCLUDE_URLS='.*github.com'
#ENV CRAWLER_APP=crawler.py
#ENV MONGO mongo
#ENV MONGO_PORT 27017
#ENV RMQ_HOST rabbit

CMD python3 -u crawler/crawler.py https://vitkhab.github.io/search_engine_test_site/
