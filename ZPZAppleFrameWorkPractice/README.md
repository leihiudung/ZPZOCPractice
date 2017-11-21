# ZPZFrameWorkPractice
个人练习项目，如果您有什么要指导的或者想一起探讨的，可以联系：微信18519140878
**Carthage（迦太基）的使用：
1、安装
使用下列两个命令就可安装
$ brew update
$ brew install carthage
2、使用
1）在工程目录下创建一个名交cartfile的文件
2）打开该文件，输入类似于github "Alamofire/Alamofire" ~> 3.0的语句，具体的课根据需要的三方库去设置
3）保存文件，执行$ carthage update --platform iOS即可安装针对于iOS手机平台的库，如果不指定platform，则会把电脑等平台的也会安装下来
4）打开项目，点击project，选择target, 再选择上方的General，将需要的framework文件拖到 Linked frameworks and Binaries内
5）点击Build Phrase tab选项，添加相应的run script
在shell下添加：/usr/local/bin/carthage copy-frameworks
在input下添加：$(SRCROOT)/Carthage/Build/iOS/SDWebImage.framework
6）使用

主要包括以下内容：
一、图片循环滑动
功能包括：占满全屏和非全屏两种情况，方向可自定义，只需初始化和做定义方向即可

二、实现UIScrollView
根据UIScrollView原理，其滑动其实是对bounds做修改

三、实现UITableView
根据UITableView原理，简单实现效果；
难点在于：如何区分dequeueReusableCellWithIdentifier的数据cell是从重用池中获取？是从当前界面中获取？还是重新创建？
