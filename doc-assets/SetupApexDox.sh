FILE=node_modules/@highlightjs/cdn-assets/highlight.min.js
if test -f "$FILE"; then
	cat node_modules/@highlightjs/cdn-assets/highlight.min.js > doc-assets/highlight.js
	echo "\n" >> doc-assets/highlight.js
	cat node_modules/highlightjs-apex/dist/apex.min.js >> doc-assets/highlight.js
else
	curl -L "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/highlight.min.js" -o "doc-assets/highlight.js"
	echo >> doc-assets/highlight.js
	curl -L "https://cdn.jsdelivr.net/npm/highlightjs-apex/dist/apex.min.js" >> "doc-assets/highlight.js"
fi

printf '<link href="assets/styling.css" rel="stylesheet" />' > "doc-assets/files/main.html"
echo >> "doc-assets/files/main.html"
npx marked -i README.md --gfm >> "doc-assets/files/main.html"
