FROM node:12.16.2 

WORKDIR /app

# Install app dependencies
COPY package*.json ./

RUN yarn --ignore-optional

# Bundle app source
COPY . /app

EXPOSE 3000