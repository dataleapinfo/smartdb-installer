# SmartDB 安装包

项目负责安装，部署，更新，管理 SmartDB

## 环境依赖

On a Linux host: docker 20.10.10-ce+ and docker-compose 1.18.0+ .

## 安装部署

```bash
# 本地安装
$ ./smartdbcli.sh install
```

## 离线安装

[从官网下载离线安装包](https://doc.dataleapinfo.com//smartdb/download/releases)

## 管理

```
# 启动
$ ./smartdbcli.sh start

# 停止
$ ./smartdbcli.sh stop

# 重启
$ ./smartdbcli.sh restart

# 日志

$ ./smartdbcli.sh log
```

## 目录说明

```
 tree .
.
├── config
│   ├── mysql
│   │   └── my.cnf
│   ├── nginx
│   │   └── smartdb.conf
│   └── redis
│       └── redis.conf
├── example.env
├── global.env
├── README.md
├── scripts
│   ├── 0.prepare.sh
│   ├── 1.config.sh
│   ├── 2.install-docker.sh
│   ├── 3.load-images.sh
│   ├── 4.install_app.sh
│   ├── 5.backup-db.sh
│   ├── 6.restore-db.sh
│   ├── 7.upgrade.sh
│   └── 8.uninstall.sh
└── yml
    ├── dbgatex-server.yml
    ├── dbgatex-web.yml
    ├── dbmanager.yml
    ├── mysql.yml
    ├── nginx.yml
    ├── redis.yml
    └── smartdb-admin.yml

6 directories, 22 files
```
