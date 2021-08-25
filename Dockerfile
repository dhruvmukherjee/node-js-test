# Build Image
FROM node:14.5 as build

WORKDIR /app

COPY package.json .

COPY tsconfig.json .

COPY index.ts .

# Build JS
RUN npm run build

# Final Image
FROM node:14.5

WORKDIR /app

COPY --from=build /app/dist /app/dist
COPY --from=build /app/package.json /app/package.json
COPY --from=build /app/node_modules /app/node_modules

COPY docs/openapi.yaml ./docs/openapi.yaml

CMD ["node", "./dist/index.js"]

EXPOSE 3000
