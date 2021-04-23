#!/bin/sh

npm install blc
gitbook serve &
gitbook_serve_pid=$!

for i in {0..9}
do
  sleep 10
  HTTP_RESPONSE=`curl -s http://localhost:4000 -o /dev/null -w "%{http_code}\n"`
  if [ ${HTTP_RESPONSE} -eq 200 ]; then
      echo "Server started"
      break
  fi
done

if [ ${HTTP_RESPONSE} -eq 200 ]; then
  echo "Start broken link check"
  date > broken-link-check.log
  blc http://localhost:4000/ -roe >> broken-link-check.log
else
  echo "Can't start broken link check"
fi

kill $gitbook_serve_pid
