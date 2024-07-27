# vim-unite-qf-replace

A Vim plugin that performs batch replacements on Unite.vim search results.

## Dependencies

This plugin depends on the following:

### Plugin
- [Unite.vim](https://github.com/Shougo/unite.vim)

## Installation

### Using dein.vim

Add the following to your `dein.toml`:

```toml
[[plugins]]
repo = 'qoncyu/vim-unite-qf-replace'
depends = ['unite.vim']
```

## Usage

1. Run Unite grep to display search results.
2. Press the default key mapping `<Leader>r` or execute `:call unite_qf_replace#replace()`.
3. Enter the replacement text.
4. Press Enter to execute the replacement.

## Customization

To change the default key mapping, add the following to your `vimrc`:

```vim
nmap <your-preferred-key> <Plug>(unite-qf-replace)
```

## Author

qoncyu

## License

MIT
