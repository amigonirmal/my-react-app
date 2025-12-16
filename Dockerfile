# Step 1: Build app
FROM node:18 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: NGINX server hosting
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
# copy custom nginx config (listens on 8080 and provides SPA fallback)
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
