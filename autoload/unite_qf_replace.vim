function! unite_qf_replace#replace() abort
  " Get the current Unite state
  let unite = unite#get_current_unite()
  if empty(unite)
    echo "Unite buffer not found. Please run Unite grep first."
    return
  endif
  " Get Unite candidates directly
  let candidates = unite.candidates
  " Get the search pattern
  let search_pattern = get(unite.context, 'input', '')

  " If search_pattern is empty, prompt for input
  if empty(search_pattern)
    let search_pattern = input('Enter the search pattern: ')
    if empty(search_pattern)
      echo "No search pattern provided. Exiting."
      return
    endif
  endif

  " Create Quickfix list
  let qflist = []
  for candidate in candidates
    if has_key(candidate, 'action__path') && has_key(candidate, 'action__line') && has_key(candidate, 'action__text')
      let filename = candidate.action__path
      let lnum = candidate.action__line
      let text = candidate.action__text
      call add(qflist, {
        \ 'filename': filename,
        \ 'lnum': lnum,
        \ 'text': text
        \ })
    endif
  endfor
  let total_items = len(qflist)
  if total_items == 0
    echo "No valid search results found."
    return
  endif
  " Set the Quickfix list
  call setqflist(qflist)
  " Escape the search pattern
  let escaped_pattern = escape(search_pattern, '/\')
  " Ask the user for the replacement text
  echo "Number of items to replace: " . total_items
  let replace_text = input('Enter the replacement text: ')
  if empty(replace_text)
    echo "No replacement text provided. Exiting."
    return
  endif
  let escaped_replace_text = escape(replace_text, '/\&')
  " Construct the replacement command
  let replace_command = '%s/' . escaped_pattern . '/' . escaped_replace_text . '/g'
  " Remember the current window
  let current_win = winnr()
  " Open the quickfix window
  copen
  " Execute the replacement
  try
    execute 'cfdo ' . replace_command . ' | update'
    echo "Replacement completed. " . total_items . " items processed."
  catch
    echo "An error occurred during replacement: " . v:exception
  finally
    " Return to the original window
    execute current_win . 'wincmd w'
  endtry
endfunction
