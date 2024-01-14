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
указав собственное значение перменной external_url (или использовать собственный инстанс gitlab) <br>
# Перенести данный репозиторий в гитлаб и выполнить пайплайн:
![alt text](https://github.com/tuturu0/otus-final-project/blob/main/img/Screenshot_1.jpg)
</br>
Для работы пайплайна необходимо в настройках gitlab добавить следующие переменные:
- CRAWLER_VERSION
- DOCKERHUB_USER
- DOCKER_TOKEN
- UI_VERSION
\
Первая задача пайплайна запускается вручную, остальные запускаются только в случае успеха предыдущих
# Рабочий сервис:
![alt text](https://github.com/tuturu0/otus-final-project/blob/main/img/Screenshot_3.jpg)
# Сборка образа:
В каталоге packer выполнить:
```bash
packer build -var-file=variables.pkr.hcl  ubuntu2204.pkr.hcl
```
Предварительно заполнив значение переменных
# Развёртка образа:
В каталоге terraform выполнить:
```bash
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```
Предварительно заполнив значение переменных <br>
В результате будет создано 2 виртуальных машины с пользователем "application" и его открытым ключом (для изменения ключа необходимо указать его в packer/configure.sh)
# Установка Docker:
Для этого используется плэйбук ansible для его запуска в каталоге ansible выполнить команду, предварительно заполнив инвентарник (в нём необходимо указать адрес gitlab сервера и сервера приложений):
```bash
ansible-playbook install_docker.yml
```
