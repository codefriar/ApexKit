printf '<link href="assets/styling.css" rel="stylesheet" />' > "doc-assets/files/main.html"
echo >> "doc-assets/files/main.html"
npx marked -i README.md --gfm >> "doc-assets/files/main.html"