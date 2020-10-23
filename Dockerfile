# NOTE: node:alpine is on v14 and im using v15 so I grabbed this guys
# https://hub.docker.com/r/mhart/alpine-node/
# build the node project
FROM mhart/alpine-node:latest
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install
RUN npm run build

# Copy build over to an nginx image to serve static files
# https://github.com/flashspys/docker-nginx-static
FROM flashspys/nginx-static
RUN apk update && apk upgrade
COPY --from=0 /usr/src/app/dist/portfolio /static