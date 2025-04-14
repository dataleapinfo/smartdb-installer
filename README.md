# DBAgent 安装包

项目负责安装，部署，更新，管理 DBAgent

## 环境依赖

- Linux x86_64
- Kernel 大于 4.0

## 配置文件

如果需要，请在安装前自定义属性默认值；否则将使用自带默认值
before_install.env

## 安装部署

```bash
# 安装
$ ./smartdbcli.sh install

# 启动应用
$ ./smartdbcli.sh start

```

## 管理应用

```
# 启动
$ ./smartdbcli.sh start

# 停止应用
$ ./smartdbcli.sh stop

# 重启
$ ./smartdbcli.sh restart

# 备份
$ ./smartdbcli.sh backup

# 状态

$ ./smartdbcli.sh status

# 日志

$ ./smartdbcli.sh logs
```

## 离线安装

[从官网下载离线安装包](https://www.dataleapinfo.com:8443/download/smartdb/)

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
├── before_install.env
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
