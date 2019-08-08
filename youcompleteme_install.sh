if [[ "$OSTYPE" == "darwin"* ]]
then
	brew install cmake
fi
# python3 vim/bundle/YouCompleteMe/install.py #without semantic for c family
python3 vim/bundle/YouCompleteMe/install.py --clang-completer		#with semantc for c family
