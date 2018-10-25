# ubuntu_spacemacs for spacemacs config
## 字体问题
https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116

- $ sudo mkdir /usr/share/fonts/opentype
- $ sudo git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
- $ sudo fc-cache -f -v

## git更新
https://blog.csdn.net/weifengdq/article/details/70228805

## 无法输入中文: 
https://emacs-china.org/t/topic/974
- Linux上有一个坑，就是有的情况下（比如我的Archlinux+LXDE）无论你的bash下怎么设置环境变量，你的图形界面的LC_CTYPE永远是en_US，这就导致你无论怎么设置，从图形界面上启动emacs，就是激活不了fcitx输入法。验证的方法就是，图形界面上启动emacs后，在emacs里 M-x shell-command 回车，然后输入 locale 查看当前emacs环境的locale设置（spacemace配置）。
- 最简单的办法是替换emacs的启动文件，就是那个.desktop文件 在/usr/share/applications/下面。直接改成Exec=env **LC_CTYPE=zh_CN.UTF-8** emacs25 %F ，加粗部分是新增的内容。
- 另外，.spacemacs文件中  (set-language-environment "UTF-8")


