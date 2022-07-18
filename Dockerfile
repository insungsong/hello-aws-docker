FROM 719823691862.dkr.ecr.ap-northeast-2.amazonaws.com/hello-aws-docker:latest as build

LABEL maintainer="whyirofficial@gamil.com"

WORKDIR /hello-aws-docker

COPY ./apps ./apps
COPY ./nest-cli.json .
COPY ./package.json .
COPY ./tsconfig.json .
COPY ./tsconfig.build.json .


RUN nest build gateway 

FROM 719823691862.dkr.ecr.ap-northeast-2.amazonaws.com/hello-aws-docker:latest as hello-aws-docker

WORKDIR /hello-aws-docker

COPY --from=build /hello-aws-docker /hello-aws-docker
