 "xxxxxxxxxxxxxxxxxxxxx 常规参数设置 xxxxxxxxxxxxxxxxxxxxxxx"

 set nocompatible            "去掉有关vi一致性模式，避免以前版本的bug和局限
 set nu!                     "显示行号
 filetype on                 "检测文件的类型
 set history=1000            "记录历史的行数
 set background=dark         "背景使用黑色
 syntax on                   "语法高亮度显示
 set autoindent              "当前行的对齐格式应用到下一行(自动缩进）
 set cindent                 "（cindent是特别针对 C语言语法自动缩进）
 set smartindent             "依据上面的对齐格式，智能的选择对齐方式，对于>类似C语言编写上有用
 set tabstop=4               "设置tab键为4个空格，
 set shiftwidth =4           "设置当行之间交错时使用4个空格
 set ai!                     " 设置自动缩进
 set showmatch               "设置匹配模式，类似当输入一个左括号时会匹配相>应的右括号
 set guioptions-=T           "去除vim的GUI版本中得toolbar
 set vb t_vb=                "当vim进行编辑时，如果命令错误，会发出警报，该设置去掉警报
 set ruler                   "在编辑过程中，在右下角显示光标位置的状态行
 set nohls                   "默认情况下，寻找匹配是高亮度显示，该设置关闭>高亮显示





call plug#begin('~/.vim/plugged')

"----------------------环境美化----------------------“   
Plug 'mhinz/vim-startify'            "修改启动界面
Plug 'vim-airline/vim-airline'       "状态栏美化
Plug 'Yggdroot/indentLine'           "增加代码缩进线条
Plug 'itchyny/lightline.vim'         "代码高亮


"----------------------编译测试----------------------“
Plug 'skywind3000/asyncrun.vim'


"自动打开 quickfix window,高度为6
let g:asyncrun_open = 6

"任务结束时候响铃
let g:asyncrun_bell = 1

"设置F10打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"F9 为编译单文件
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"F5 为单文件运行
nnoremap <silent> <F5> :AsyncRun -cwd=$(VIM_FILEDIR) -mode=4 "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"定位到文件所属项目的目录
"let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 

"F7 编译整个项目
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>



"----------------------语法检查----------------------“
Plug 'W0rp/ale'

"配置ALE"

"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'

"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']

"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>

"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>



"----------------------自动索引----------------------“
Plug 'ludovicchabant/vim-gutentags'

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif


"----------------------修改比较----------------------“
Plug 'mhinz/vim-signify'
"set signcolumn=yes


"----------------------文本对象----------------------“
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'


"----------------------代码补全----------------------“
Plug 'ycm-core/YouCompleteMe'

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }


"----------------------代码注释----------------------“
Plug 'Yggdroot/indentLine'  " gc注释/取消注释      



"----------------------参数提示----------------------“   
Plug 'Shougo/echodoc.vim'
set noshowmode


"----------------------Git相关----------------------“   
Plug 'tpope/vim-fugitive'



"----------------------文件相关----------------------“      
"======显示函数列表 文件切换 文件浏览======“
Plug 'Yggdroot/LeaderF'

let g:Lf_ShortcutF = '<c-p>'                  "CTRL+P 在当前项目目录打开文件搜索       
let g:Lf_ShortcutB = '<m-n>'                  "CTRL+N 打开 MRU搜索，搜索你最近打开的文件 模糊匹配   
noremap <c-n> :LeaderfMru<cr>                 "ALT+P  打开函数搜索
noremap <m-p> :LeaderfFunction!<cr>           "ALT+N  打开 Buffer 搜索
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}


"======目录浏览======”
Plug 'scrooloose/nerdtree'

""将F2设置为开关NERDTree的快捷键
map <F2> :NERDTreeToggle<CR>
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
""窗口位置
let g:NERDTreeWinPos='left'
""窗口尺寸
let g:NERDTreeSize=30
""窗口是否显示行号
let g:NERDTreeShowLineNumbers=1
""不显示隐藏文件
let g:NERDTreeHidden=0
""打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
""当NERDTree为剩下的唯一窗口时自动关闭
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""打开vim时自动打开NERDTree
"autocmd vimenter * NERDTree


"======快速定位======”
Plug 'easymotion/vim-easymotion'
" for easy-motion
map <Leader><Leader>w <Plug>(easymotion-w)
map <Leader><Leader>f <Plug>(easymotion-f)
map <Leader><Leader>b <Plug>(easymotion-b)
nmap ss <Plug>(easymotion-s2)
nmap sd <Plug>(easymotion-s)
nmap sf <Plug>(easymotion-overwin-f)
map  sh <Plug>(easymotion-linebackward)
map  sl <Plug>(easymotion-lineforward)

"======头文件/源文件快速切换======“
Plug 'vim-scripts/a.vim'


call plug#end()

" 退出快捷键
inoremap jj <Esc>`^
inoremap hhh <Esc>`^
inoremap kkk <Esc>`^
inoremap lll <Esc>`^
inoremap ooo <Esc>`^o
inoremap <C-k> <Esc>`^
inoremap <leader>w <Esc>:w<cr>
noremap <leader>e :q<cr>
noremap <leader>E :qa!<cr>
noremap <leader>b :bd<cr>
noremap <leader>s :vs<cr>  
noremap <leader>r :e!<cr>  
noremap <leader>q :qa!<cr>  
noremap <leader>w :w<cr>

" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
