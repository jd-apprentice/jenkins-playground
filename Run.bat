@echo off

REM
:all
    echo Usage: %~nx0 [network | build | run | clear]
    exit /b 1

:network
    call :create_network
    goto :eof

:build
    call :build_image
    goto :eof

:run
    call :run_container
    goto :eof

:clear
    call :clear_resources
    goto :eof

REM
:create_network
    docker network create jenkins > logs\network.log 2> logs\network.err
    goto :eof

:build_image
    cd docker
    docker build -t jenkins:4.414.1-1 -f Jenkins.Dockerfile . 2> logs\build.err
    cd ..
    goto :eof

:run_container
    docker run ^
    --name jenkins ^
    --restart=on-failure ^
    --detach ^
    --network jenkins ^
    --env DOCKER_HOST=tcp://docker:2376 ^
    --env DOCKER_CERT_PATH=/certs/client ^
    --env DOCKER_TLS_VERIFY=1 ^
    --publish 8080:8080 ^
    --publish 50000:50000 ^
    --volume /var/run/docker.sock:/var/run/docker.sock ^
    --volume %ProgramFiles%\Docker\docker.exe:/usr/bin/docker ^
    --volume jenkins-data:/var/jenkins_home ^
    --volume jenkins-docker-certs:/certs/client:ro ^
    jenkins:4.414.1-1
    goto :eof

:clear_resources
    docker rm -f jenkins 2>NUL
    docker volume rm jenkins-data 2>NUL
    docker volume rm jenkins-docker-certs 2>NUL
    docker image rm jenkins:4.414.1-1 2>NUL
    goto :eof

REM
if "%~1"=="" goto :all

REM
call :%~1
