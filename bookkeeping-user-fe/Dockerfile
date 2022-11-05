#FROM nginx:1.21-alpine
#COPY ./docker/nginx.conf.template /etc/nginx/templates/default.conf.template
#COPY ./docker/gzip.conf /etc/nginx/conf.d/gzip.conf
#COPY ./dist/ /usr/share/nginx/html

FROM node:16-slim as build
WORKDIR /workspace/app
COPY src src
COPY package.json .
COPY package-lock.json .
RUN npm install
RUN npm run build

FROM nginx:1.21-alpine
COPY ./docker/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY ./docker/gzip.conf /etc/nginx/conf.d/gzip.conf
COPY --from=build /workspace/app/dist/ /usr/share/nginx/html
