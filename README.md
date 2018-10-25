# ubuntu_spacemacs for spacemacs config
https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116

$ sudo mkdir /usr/share/fonts/opentype

$ sudo git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp

$ sudo fc-cache -f -v


https://blog.csdn.net/weifengdq/article/details/70228805

无法输入中文: https://emacs-china.org/t/topic/1271/22
$ LC_CTYPE=zh_CN.UTF-8 emacs --daemon
$ emacsclient --create-frame --no-wait
