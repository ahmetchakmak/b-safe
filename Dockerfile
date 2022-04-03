FROM node:13-alpine3.10 as base
COPY . .

WORKDIR /
RUN npm i
RUN npm run build
CMD ["npm","start"]