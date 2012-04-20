all:
	[ -d ~/.vim/ ] || ln -s ~/dotfiles/vim/ ~/.vim
	[ -f ~/.vimrc ] || ln -s ~/dotfiles/vim/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s ~/dotfiles/zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s ~/dotfiles/gitconfig ~/.gitconfig
	[ -f ~/.tmux.conf ] || ln -s ~/dotfiles/tmuxconf ~/.tmux.conf

clean:
	rm -f ~/.vimrc ~/.zshrc ~/.vim ~/.zsh

.PHONY: all
