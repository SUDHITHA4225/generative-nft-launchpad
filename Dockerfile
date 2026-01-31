# ---------- Hardhat ----------
FROM node:18-alpine AS contracts
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
CMD ["npx", "hardhat", "node"]

# ---------- Frontend ----------
FROM node:18-alpine AS frontend
WORKDIR /frontend
COPY frontend/package.json ./
RUN npm install
COPY frontend .
CMD ["npm", "run", "dev"]
