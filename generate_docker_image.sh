
docker build -t nginx .
docker tag nginx didiegovieira/study:$1
docker push didiegovieira/study:$1
