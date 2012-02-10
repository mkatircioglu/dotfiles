all:
	[ -d ~/.vim/ ] || ln -s ~/dotfiles/vim/ ~/.vim
	[ -f ~/.vimrc ] || ln -s ~/dotfiles/vim/vimrc ~/.vimrc
	[ -d ~/.zsh/ ] || ln -s ~/dotfiles/zsh/ ~/.zsh
	[ -f ~/.zshrc ] || ln -s ~/dotfiles/zshrc ~/.zshrc

clean:
	rm -f ~/.vimrc ~/.zshrc ~/.vim ~/.zsh

.PHONY: all
