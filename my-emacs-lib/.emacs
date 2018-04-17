;;;从emacs安装插件，m-x list-packages
(require 'package)
(setq package-archives '(
			; ("gnu" . "http://elpa.gnu.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ))
(package-initialize)


 ;;加载 Color Theme
 (add-to-list 'load-path "~/my-emacs-lib")
(require 'molokai-theme)
(setq molokai-theme-kit t)
(set-cursor-color "gold1")
 ;(require 'color-theme)
 ;(color-theme-initialize)
 ;(color-theme-matrix)

;设置shirt-space为marked标记
(global-set-key [?\S- ] 'set-mark-command)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
 (setq mac-command-modifier 'meta)
  ;;(global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )
(setq mac-option-modifier 'meta)
 
;显示行号
(global-linum-mode t)

;显示滚动条等 
(scroll-bar-mode 1)
;(menu-bar-mode 0)
(tool-bar-mode 0)

;yes和no替换成y和n
(fset 'yes-or-no-p 'y-or-n-p)

;;全屏
(setq default-frame-alist
             '((vertical-scroll-bars)
               (top . 0)
               (left . 0)
               (width . 200)
               (height . 54)
               (right-fringe)
               (left-fringe)))

;;;;cedet
(load-file "~/my-emacs-lib/cedet-1.1/common/cedet.el")    ;你的安装目录
(require 'cedet) 

(global-ede-mode 1)
(global-srecode-minor-mode 1)
(global-semantic-mru-bookmark-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semanticdb-minor-mode 1)



;(semantic-load-enable-code-helpers)  有问题
(semantic-load-enable-minimum-features)

;(semantic-load-enable-gaudy-code-helpers) 有问题



;f12跳转到函数定义
;shirt-f12跳回原处
;command-shirt-f12跳转到函数声明
;command-n自动补全
;command-f12在h和cpp之间跳转
;;C-c -  折叠当前函数
;;C-c =  展开当前函数
;;C-_  折叠所有函数
;;C-+  展开所有函数

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (semantic-load-enable-guady-code-helpers)

(semantic-load-enable-semantic-debugging-helpers)

; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public"
       "../.." "../../include" "../../inc" "../../common" "../../public"))

(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (mapc (lambda (dir)
        (semantic-add-system-include dir 'c++-mode)
        (semantic-add-system-include dir 'c-mode))
       include-dirs))

(global-set-key [f12] 'semantic-ia-fast-jump)
(global-set-key [S-f12]
             (lambda ()
               (interactive)
              (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                  (error "Semantic Bookmark ring is currently empty"))
               (let* ((ring (oref semantic-mru-bookmark-ring ring))
                     (alist (semantic-mrub-ring-to-assoc-list ring))
                     (first (cdr (car alist))))
                 (if (semantic-equivalent-tag-p (oref first tag)
                                          (semantic-current-tag))
                    (setq first (cdr (car (cdr alist)))))
                 (semantic-mrub-switch-tags first))))

(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)
(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)



(enable-visual-studio-bookmarks);;可视化书签

(require 'eassist nil 'noerror)
(define-key c-mode-base-map [M-f12] 'eassist-switch-h-cpp) ;h/cpp 切换
(setq eassist-header-switches
     '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
       ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
       ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
       ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
       ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
       ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
       ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
       ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
       ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
       ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
       ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
       ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
       ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
       ("c" . ("h"))
       ("m" . ("h"))
       ("mm" . ("h"))))


(when (and window-system (require 'semantic-tag-folding nil 'noerror))
  (global-semantic-tag-folding-mode 1)
(global-set-key (kbd "C-?") 'global-semantic-tag-folding-mode)
(define-key semantic-tag-folding-mode-map (kbd "C-c -") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c =") 'semantic-tag-folding-show-block)
(define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
 (define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;ecb
(setq stack-trace-on-error t)
(add-to-list 'load-path "~/my-emacs-lib/ecb-2.40")    ;你的ecb解压目录
(require 'ecb)
(require 'ecb-autoloads)


(global-set-key (kbd "<f7>") 'ecb-minor-mode)   ; 打开ejb
;;;;ejb 快捷键
(global-set-key (kbd "C-<left>") 'windmove-left)   ;左边窗口
(global-set-key (kbd "C-<right>") 'windmove-right)  ;右边窗口
(global-set-key (kbd "C-<up>") 'windmove-up)     ; 上边窗口
(global-set-key (kbd "C-<down>") 'windmove-down)   ; 下边窗口


;;git-emacs
(add-to-list 'load-path "~/my-emacs-lib/git-emacs/")
(require 'git-emacs)



;;;;common lisp开发环境
;C-c C-c 编译当前函数
;C-c C-q 补全括号
(setq temporary-file-directory "~/.emacs.d/tmp") 
(add-to-list 'load-path "/usr/local/lib/sbcl")
;(add-to-list 'load-path "/usr/local/bin/sbcl")
(setq inferior-lisp-program "sbcl")  
(add-to-list 'load-path "~/my-emacs-lib/slime/")  
;(require 'slime)  
;(slime-setup)  
(require 'slime-autoloads)
(slime-setup '(slime-fancy))
(define-key slime-repl-mode-map (kbd "C-c C-q") 'slime-close-all-parens-in-sexp)


;;关闭emacs启动时的画面
(setq inhibit-startup-message t)
;;关闭gnus启动时的画面
(setq gnus-inhibit-startup-message t)

;; 设定不产生备份文件
(setq make-backup-files nil)

;;自动保存模式
(setq auto-save-mode nil)

;; 不生成临时文件
(setq-default make-backup-files nil)

;;鼠标自动避开指针，如当你输入的时候，指针到了鼠标的位置，鼠标有点挡住视线了
(mouse-avoidance-mode 'animate)

;;滚动页面时比较舒服，不要整页的滚动
(setq scroll-step 1
scroll-margin 3
scroll-conservatively 10000)

;;设定删除保存记录为200，可以方便以后无限恢复
(setq kill-ring-max 200)

;; 语法高亮
(global-font-lock-mode t)

;;显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)


;;自动补全括号
;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
    (?` ?` _ "''")
    (?\( ? _ " )")
    (?\[ ? _ " ]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(tool-bar-mode nil))

(put 'upcase-region 'disabled nil)


;;;;;;;;;;;;;org2blog
;   firstly,M-x org2blog/wp-mode RET.
;          C-c M-p p  'org2blog/wp-post-buffer-and-publish
;	   C-c M-p P 'org2blog/wp-post-buffer-as-page-and-publish
;	   C-c M-p d 'org2blog/wp-post-buffer
;	   C-c M-p D 'org2blog/wp-post-buffer-as-page
;	   C-c M-p t 'org2blog/wp-complete-category
;	   C-c M-p n 'org2blog/wp-new-entry
;	   C-c M-p i 'org2blog/wp-login
;	   C-c M-p o 'org2blog/wp-logout

(setq load-path (cons "~/my-emacs-lib/org2blog/" load-path))
(require 'org2blog-autoloads)
(require 'auth-source) ;; or nothing if already in the load-path
;(setq url-proxy-services '(("http" . "127.0.0.1:8087"))) ;设置代理
;; default is ~/org/ -- I'm putting orgmode's default dir with my other notes
(setq org-directory "~/blog/")
;; and you need this, else you'll get symbol void errors when doing
;; fill paragraph
(setq org-list-allow-alphabetical t)

(let (credentials)
  (add-to-list 'auth-sources "~/my-emacs-lib/org2blog/.netrc")
  (setq credentials (auth-source-user-and-password "ustc"))
  (setq org2blog/wp-blog-alist
	`(("ustc"
	   :url "https://fhln.blog.ustc.edu.cn/xmlrpc.php"
	   :username ,(car credentials)
	   :password ,(cadr credentials)
           :default-title "Hello World"
       	   :default-categories ("org2blog" "emacs")
	   :tags-as-categories nil))))

; * `M-x package-install RET htmlize` is required, else you get empty
;;   code blocks https://github.com/punchagan/org2blog/blob/master/org2blog.el
;; * with wp-use-sourcecode-shortcode set to 't, org2blog will use 1
;;   shortcodes, and hence the SyntaxHighlighter Evolved plugin on your blog.
;;   however, if you set this to nil, native Emacs highlighting will be used,
;;   implemented as HTML styling. Your pick!
(require 'htmlize)
(require 'metaweblog)
(require 'xml-rpc)
(setq org2blog/wp-use-sourcecode-shortcode nil)
;; removed light="true"
(setq org2blog/wp-sourcecode-default-params nil)
;; target language needs to be in here
(setq org2blog/wp-sourcecode-langs
      '("actionscript3" "bash" "coldfusion" "cpp" "csharp" "c" "css" "delphi"
        "erlang" "fsharp" "diff" "groovy" "javascript" "java" "javafx" "matlab"
        "objc" "perl" "php" "text" "powershell" "python" "ruby" "scala" "sql"
        "vb" "xml"
        "sh" "emacs-lisp" "lisp" "lua"))
;; this will use emacs syntax higlighting in your #+BEGIN_SRC
;; <language> <your-code> #+END_SRC code blocks.
(setq org-src-fontify-natively t)


;Smex让输入命令变得飞快
(setq load-path (cons "~/my-emacs-lib/smex/" load-path))
(require 'smex) 
(smex-initialize) 
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;switch-window切换窗口,按"C-x O"一次,会有提示子窗口编号
(setq load-path (cons "~/my-emacs-lib/switch-window/" load-path))
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;window-numbering
;Enable `window-numbering-mode` and use M-1 through M-0 to navigate.
;If you want to affect the numbers, use window-numbering-before-hook or window-numbering-assign-func.
(setq load-path (cons "~/my-emacs-lib/window-numbering/" load-path))
(require 'window-numbering)
(window-numbering-mode 1)

;;;company-mode http://company-mode.github.io
;M-n and M-p to select,
;<return> to complete or <tab> to complete the common part
;Search through the completions with C-s, C-r and C-o
;M-(digit) to quickly complete with one of the first 10 candidates
;When the completion candidates are shown:
;;press <f1> to display the documentation for the selected candidate, 
;or C-w to see its source
(add-hook 'after-init-hook 'global-company-mode)

;flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)


;; w3m
;load & init 
(autoload 'w3m "w3m" "interface for w3m on emacs" t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
;settings
(setq w3m-use-cookies t)
(setq w3m-home-page "http://www.baidu.com")
;(require 'mime-w3m)
;; 默认显示图片
(setq w3m-default-display-inline-image t) 
(setq w3m-default-toggle-inline-images t)  
;; 使用cookies
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq browse-url-browser-function 'w3m-browse-url)
(setq w3m-view-this-url-new-session-in-background t)

(put 'scroll-left 'disabled nil)
