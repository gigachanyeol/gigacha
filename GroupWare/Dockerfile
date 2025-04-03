# 1. 베이스 이미지를 Ubuntu 22.04로 설정
FROM ubuntu:22.04

# 2. 필수 패키지 설치 (openjdk-17-jdk, git, maven, curl 등)
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    git \
    maven \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 3. Tomcat 설치 (tar.gz 파일을 다운로드하여 압축 풀기)
RUN curl -SL https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.tar.gz -o /home/tomcat.tar.gz \
    && tar -xzvf /home/tomcat.tar.gz -C /home/ \
    && rm /home/tomcat.tar.gz
    
# db연결을 위한 wallet 복사
COPY /home/Wallet_N3PVS6LM6K85IAM9 /home

# 4. Git 리포지토리에서 소스를 클론하여 빌드 (Maven)
WORKDIR /home/spring
RUN git clone https://github.com/chan0yeol/gigachamvc.git \
    && cd gigachamvc/GroupWare \
    && mvn clean package -Dmaven.compile.skip=true -DskipTests

# 5. WAR 파일을 Tomcat의 webapps 디렉토리로 이동
RUN mv /home/spring/gigachamvc/GroupWare/target/*.war /home/apache-tomcat-9.0.102/webapps/GroupWare.war

# 6. Tomcat 포트 노출
EXPOSE 8080

# 7. Tomcat 서버 실행
ENTRYPOINT ["/home/apache-tomcat-9.0.102/bin/catalina.sh", "run"]