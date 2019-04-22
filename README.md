# ES cluster for Rainbond deployment
#### 介绍
适用于 [Rainbond](https://www.rainbond.com/) 的 docker 化集群版 elasticsearch 6.2.3


#### 安装教程

1. 拥有一套私有化的Rainbond平台，或者使用 https://console.goodrain.com 公有云环境
2. 使用当前仓库进行源码构建

#### 使用说明

1. 作为集群版的 ES 应用，构建时设置最少3个实例
2. 构建时服务部署类型选择有状态服务
3. 单实例最小内存2G
4. 通过修改 Dockerfile 中的基础镜像来调整 ES 版本
5. 由于 ES 集群机制的不同，ES 的版本请使用 6.X+ 

#### 参与贡献

1. Fork 本仓库
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request

