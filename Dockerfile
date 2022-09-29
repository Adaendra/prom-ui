FROM node:alpine

# --- Install tools
RUN apk update && apk add git && apk add make g++
RUN apk add bash

# - Install Python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN  apk add --no-cache bash git openssh make cmake

# --- Setup Working Directory
WORKDIR /app

# --- Copy the whole content of the project
COPY . /app

# --- Set Permissions for Packages
RUN npm config set unsafe-perm true

# --- Build
RUN npm ci
RUN npm run build

# --- Change permissions to avoid issue with node modules
RUN chown -R node /app/react-app

USER node

EXPOSE 3000

CMD ["npm", "run", "start"]