from node:12

run apt-get update
run apt-get install -y postgresql-client=9.6*

workdir /app
copy . .

run npm install

expose 3000
