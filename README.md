# docker-zentao

禅道Docker Image File（开源版）
本代码，直接同步自官方 https://www.zentao.net/book/zentaopmshelp/303.html 

数据库，使用自有的数据库。

可挂载目录
/app/zentaopms:该目录为禅道目录，里面包含禅道代码及附件上传目录。
/var/lib/mysql:该目录为数据库的数据目录。

首次运行容器后，浏览器访问http://IP:端口，如果界面显示禅道安装界面，说明容器运行正常。
依照安装程序，最后将禅道安装成功，就可以使用禅道了。

---


对于MYSQL8的错误“数据库连接失败
```
SQLSTATE[HY000] [2054] The server requested authentication method unknown to the client”
```
单独创建用户使用密码规则`mysql_native_password` 
```
CREATE USER `zentao`@`%` IDENTIFIED WITH mysql_native_password BY 'zentao';
```


