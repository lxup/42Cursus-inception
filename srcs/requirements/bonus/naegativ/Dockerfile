# Stage 1: Build Stage
FROM node:16-buster as builder

# INSTALL DEPENDENCIES
RUN apt-get update && \
    apt-get install -y git

# CLONE REPOSITORY
RUN git clone https://github.com/lxup/naegativ.git /naegativ
WORKDIR /naegativ

# INSTALL NODE MODULES
RUN npm install

# BUILD NEXT.JS APP
RUN npm run build

# Stage 2: Production Stage
FROM node:16-buster-slim as runner

# INSTALL NODE
RUN apt-get update && \
    apt-get install -y nodejs

# COPY BUILT FILES FROM BUILD STAGE
WORKDIR /app
COPY --from=builder /naegativ .

# INSTALL PRODUCTION DEPENDENCIES
RUN npm install --only=prod

# EXPOSE PORT
# EXPOSE 3000

# START APPLICATION
CMD ["npm", "start"]
