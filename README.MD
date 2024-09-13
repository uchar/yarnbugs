docker build -t yarn_bug .

yarn exec "docker run -d -e EXEC_COMMAND=test1 yarn_bug"
