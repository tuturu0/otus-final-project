# Используемые инструменты:
- docker
- docker compose
- promitheus
- grafana
- elsticsearch
- fluentd
- kibana
 
# Для начала необходимо склонировать репозиторйи на целевой хост в каталог /docker_sys/crawler (необходимо для пайплайна gitlab):
```bash
git clone  git@github.com:tuturu0/otus-final-project.git
```
# Далее необходимо перейти в каталог и запустить сервисы мониторинга и логирования командами:
```bash
docker compose -f docker-compose-monitoring.yml up -d
docker compose -f docker-compose-logging.yml up -d
```
Grafana:
![alt text](https://github.com/tuturu0/otus-final-project/blob/main/img/Screenshot_4.jpg)
Kibana:
![alt text](https://github.com/tuturu0/otus-final-project/blob/main/img/Screenshot_5.jpg)
# Далее для запуска сервиса crawler вручную необходимо:
```bash
docker compose up -d
```
# Для использования пайплайна gitlab необходимо перейти в каталог gitlab и выполнить:
```bash
docker compose up -d
```
указав собственное значение перменной external_ur (или использовать собственный инстанс gitlab) <br>
# Перенести данный репозиторий в гитлаб и выполнить пайплайн:
![alt text](https://github.com/tuturu0/otus-final-project/blob/main/img/Screenshot_1.jpg)
<br>
Для работы пайплайна необходимо в настройках gitlab добавить следующие переменные:
- CRAWLER_VERSION
- DOCKERHUB_USER
- DOCKER_TOKEN
- UI_VERSION
