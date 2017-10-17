# RXSwiftDemoTest
##这是一个简单的swift测试demo，已经适配了iPhone X


主要分为四个模块

* 百思不得姐接口请求显示
* 图书查询
* 汽车品牌知识查询介绍
* 微信资讯

##1.百思不得姐
模块1中具体就是整合了tableView，使用swift自定义cell，动态计算cell的高度，显示git动态图，判断图片的最大高度，在一定高度上只显示一部分，使用了YYCache和YYImage显示动态图

模块2中添加了一个图书查询demo和仿知乎demo(码代码中……),在首页中使用rxswift创建了一个tableView的，替代了系统的代理方发和数据源代理方法

模块3中首页展示汽车品牌，根据汽车品牌进行选择，可以查看汽车的具体显示信息

模块4中是对微信资讯的一个展示，根据请求的分类进行处理数据，自定义cell显示

![图片显示](https://github.com/zhangjiang1203/SwiftBaseProject/blob/master/SwiftBaseProject/swiftTestDemo.gif)
