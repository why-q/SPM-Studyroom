# FDU-StudyRoom 软件管理项目

\***

该项目最新版本为 [v1.1.2](https://github.com/why-q/SPM-Studyroom)，点击链接可查看公共 Github 仓库。

\***

本项目已经配置好了自动集成测试、自动编译构建和自动部署。如果想要手动部署的话，可以按照以下步骤：

1. 安装必要依赖：

```bash
apt-get update && apt-get install -y \
    wget \
    curl \
    netcat \
    lsof \
    gnupg2 \
    software-properties-common \
    maven \
    openjdk-8-jdk \
    gosu \
    sudo
```

2. 运行 `docker-entrypoint.sh` 脚本即可自动完成所有剩余操作：`bash docker-entrypoint.sh`

\***

CI/CD 的具体代码请参考以下文件：

- 配置 Github Actions：`./github/workflows/main.yml`
- Docker 镜像配置：`./dockerfile`
- Docker Container 入口脚本：`./docker-entrypoint.sh`
- 数据库自动创建脚本：`./auto_create.sql`

\***

截图主要包括 CICD 平台截图以及系统成品截图，放于文件夹 `./screenshots` 内；自动化测试、编译构建、部署以及系统功能的简要视频展示放于文件夹 `./screen-recordings` 内；软件最新版本 JAR 包放于 `./packages` 内；课程 PPT 放于文件夹 `./ppt` 内。