FROM 719823691862.dkr.ecr.ap-northeast-2.amazonaws.com/hello-aws-docker:latest as build

LABEL maintainer="whyirofficial@gamil.com"

WORKDIR /hello-aws-docker

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

COPY ./apps ./apps
COPY ./nest-cli.json .
COPY ./package.json .
COPY ./tsconfig.json .
COPY ./tsconfig.build.json .

ENV PATH=${PATH}:./node_modules/.bin

RUN nest build gateway \
&& rm -fr apps libs

FROM 719823691862.dkr.ecr.ap-northeast-2.amazonaws.com/hello-aws-docker:latest as hello-aws-docker

WORKDIR /hello-aws-docker

COPY --from=build /hello-aws-docker /hello-aws-docker
