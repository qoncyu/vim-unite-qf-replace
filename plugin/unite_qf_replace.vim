if exists('g:loaded_unite_qf_replace')
  finish
endif
let g:loaded_unite_qf_replace = 1

nnoremap <Plug>(unite-qf-replace) :call unite_qf_replace#replace()<CR>

if !hasmapto('<Plug>(unite-qf-replace)')
  nmap <Leader>r <Plug>(unite-qf-replace)
endif
