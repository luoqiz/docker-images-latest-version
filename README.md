# docker-images-latest-version

获取 dockerhub 上指定镜像的最新版本号（剔除latest）<br/>

## Action inputs

| name             | description                                                                                                                                                                                                                                                                                                                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `image`          | (必须值) 需要获取的镜像名称 <br/> 示例： 使用用户的镜像,image: `luoqiz/zerotier-one` <br/> 使用官方提供的镜像，image: `library/nginx` <font color="#dd0000"> 不可省略`library`  </font>                                                                                                                                                                                                                                    |

## Action outputs

| name            | description                                            |
| --------------- | ------------------------------------------------------ |
| `version`       | 返回镜像的最新版本号（剔除了 latest 版本）                   |

## Example usage

```yaml
name: Deploy

on:
  push:
    branches:
      - master

jobs:
  chenck_version:
    runs-on: ubuntu-latest
    outputs:
      nginx_version: ${{ steps.get_nginx_version.outputs.version }}
    steps:
      - name: Get nginx version
        uses: luoqiz/docker-images-latest-version@master
        id: get_nginx_version
        with:
          image: library/nginx

  push:
    needs: chenck_version

    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: cat nginx version
        run: echo ${{ needs.chenck_version.outputs.nginx_version }}
      
      - name: compare and do something
        run: echo true
```