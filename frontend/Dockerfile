# syntax=docker/dockerfile:1

FROM node:18-alpine
WORKDIR /
RUN apk --no-cache add git
RUN git clone https://github.com/Team-Olya/frontend.git -b dev
WORKDIR /frontend
RUN npm install
CMD ["npm", "run", "build"]