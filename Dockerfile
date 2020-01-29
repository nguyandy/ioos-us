FROM node:13.7.0-alpine
MAINTAINER RPS Dev-Ops <devops@rpsgroup.com>

COPY bin /opt/ioos-us/bin
COPY public /opt/ioos-us/public
COPY routes /opt/ioos-us/routes
COPY views /opt/ioos-us/views
COPY app.js assets.json gruntfile.js package.json /opt/ioos-us/

# install yarn
RUN apk update && \
    apk add yarn

# install grunt 
RUN npm install -g grunt

# change ownership, directory
RUN chown -R node:node /opt/ioos-us
WORKDIR /opt/ioos-us

# install using yarn
RUN yarn

# grunt
RUN node node_modules/grunt-cli/bin/grunt

ENV NODE_ENV production

CMD ["node", "bin/www"]
