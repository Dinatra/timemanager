FROM node:lts-alpine as build-stage

ARG VUE_APP_API_URL="/"

EXPOSE 8080

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN echo VUE_APP_API_URL=${VUE_APP_API_URL} > .env

RUN npm run build

# étape de production
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
