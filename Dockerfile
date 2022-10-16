# FROM [base镜像] 必须放在Dockerfile的第一行，表示从哪个baseimage开始构建
FROM node:slim

# MAINTAINER: 可选的，用来标识image作者的地方

# ADD & COPY
# 当在源代码构建的方式下，可以通过ADD和COPY的方式，把host上的文件或者目录复制到image中
# ADD和COPY的源必须在context路径下
# 当src为网络URL的情况下，ADD指令可以把它下载到dest的指定位置，这个在任何build的方式下都可以work
# ADD相对COPY还有一个多的功能，能够进行自动解压压缩包
COPY ./ /usr/local/app

# 用来指定当前工作目录（或者称为当前目录） 当使用相对目录的情况下，采用上一个WORKDIR指定的目录作为基准
WORKDIR /usr/local/app

# 一个Dockerfile中可以包含多个RUN，按定义顺序执行 每一个RUN指令都会是在一个新的container里面运行，并提交为一个image作为下一个RUN的base
RUN npm i

# CMD: 
# CMD的作用是作为执行container时候的默认行为（容器默认的启动命令）
# 当运行container的时候声明了command，则不再用image中的CMD默认所定义的命令
# 一个Dockerfile中只能有一个有效的CMD，当定义多个CMD的时候，只有最后一个才会起作用

# ENV key value
# 用来设置环境变量，后续的RUN可以使用它所创建的环境变量
ENV NODE_ENV dev

# EXPOSE <端口1> [<端口2>...]。
# EXPOSE 指令是声明运行时容器提供服务端口，这只是一个声明，在运行时并不会因为这个声明应用就会开启这个端口的服务。在 Dockerfile 中写入这样的声明有两个好处，一个是帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射；另一个用处则是在运行时使用随机端口映射时，也就是 docker run -P 时，会自动随机映射 EXPOSE 的端口。
EXPOSE 8090

# HEALTHCHECH 健康检查
# HEALTHCHECK CMD curl --fail http://localhost:5000/fundation || exit 1