# Stage 1 : Builder
FROM node:18-alpine as builder

WORKDIR /app

COPY src ./src
COPY ["*.json","nginx.conf", "./" ]

# RUN sleep 3600
RUN npm i
RUN npm run production

FROM nginx:1.19.8-alpine
COPY --from=builder /app/dist/country-app/ /usr/share/nginx/html/
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 4200