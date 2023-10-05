#!/bin/bash
# shellcheck disable=SC2164
#SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
# cd $SCRIPT_PATH/..

# Remove old docs
rm -fr docs &&
# \
#rm -fr force-app/main/default/staticresources/documentation && \

# Generate Apex doc files
./node_modules/.bin/apexdocs-generate -p global public private protected namespaceaccessible -s force-app/main/ -g plain-markdown --sanitizeHtml --includeMetadata && \

# Remove doc index
#rm docs/index.md && \

mv docs/index.md docs/home.md && \

# Flatten directory structure
find docs/* -mindepth 1 -type f -exec mv -i '{}' docs ';' && \

# Remove empty folders
find docs/* -type d -empty -delete && \

# Replace relative links and remove .md extension
find docs/ -type f -name "*.md" -print0 | xargs -0 sed -i "" -E "s@]\(\.\/(.*)\.md@](https://github.com/codefriar/ApexKit/wiki/\1@g" && \
find docs/ -type f -name "*.md" -print0 | xargs -0 sed -i "" -E "s@\]\(\.\.\/.*\/(.*)\.md@](https://github.com/codefriar/ApexKit/wiki/\1@g" && \

# Remove first three line with layout header
find docs/ -type f -name "*.md" -print0 | xargs -0 sed -i "" "1,3d"

# Move docs
#mv docs force-app/main/default/staticresources/documentation