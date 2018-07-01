# Makefile
#
#

MAKE = make

CD = cd
MOVE = mv
COPY = cp
RM   = rm 

#
# /
# |---- libraries/
# |         |---- mini-httpd...tar.gz
# |         |---- DebugLog_solution.zip
# |
# |
# |---- Makefile(<--this file)
# |
# |---- src/
# |---- html/
# |---- res/
# |
# |
# |---- WorkPath/
#


###
### 这里设定 libraries 的相关内容！
### 这里是文件夹
###
Libraries      := libraries


CGI_PROGRAM = src

.PHONY: $(Libraries) lib all install clean

###
### make lib => 需要 mini_httpd;  cgic.a, flate.a, cgiDebugLog.a 
###
lib: $(Libraries)

$(Libraries):
	$(MAKE) --directory=$@

###
### make all ==> 将所有 src/*.c --编译成--> src/*.cgi 
###   需要 web.so cgic.so 等的支持， 依赖于 `$ make lib`
###
#all: --mini_httpd-- --cgic.so-- --web.so--

## make all = make lib + make src ##+ make Lib&Bin
all: $(CGI_PROGRAM)


###
### 应用程序 与 库链接 的依存关系
### (*.cgi)    (mini_httpd, cgiDebugLogd, cgic.so web.so)
###
$(CGI_PROGRAM): $(Libraries) ## $(Lib&Bin_DIR)

###
### 以下编译了 *.cgi， 并且确保依赖库要被编译。
###
$(CGI_PROGRAM):
	$(MAKE) --directory=$@   
## 
## ^^ 以上， 调用了 src/Makefile & libraries/Makefile
##
#$(Lib&Bin_DIR):
#	$(MAKE) --directory=$@


###
### make install ==> 将 src/*cgi html/*.html res/*.json *.js *.css 安装
###   需要检查当前是否有 CGIDebugLogd 在运行， 
###   以及 mini_httpd 是否在运行。
###   没有的话， 需要打印提示消息！
###
install:
	$(MAKE) --directory=$(Libraries) install


#clean:

