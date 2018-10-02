all: index.html debug.html

debug.html: src/Main.elm elm.json
	elm make src/Main.elm --debug --output=debug.html

index.html: src/Main.elm elm.json
	elm make src/Main.elm --optimize --output=index.html
