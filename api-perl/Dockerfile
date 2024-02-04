FROM perl:5.38.2-bullseye

WORKDIR /api-perl

RUN cpanm Mojolicious
COPY ./app.pl ./

CMD ["perl", "app.pl", "daemon", "-l", "http://*:3000"]
