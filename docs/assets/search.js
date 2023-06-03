import documents from './search-idx.js';

let searchDelay = null;
let timeoutHandle = 0;
const input = document.querySelector('#search-input');
const searchResults = document.querySelector('#search-results');

/** ==================================================================
 *  Create Lunr search index
 *  ==================================================================
 */

const index = lunr(function () {
	this.ref('fileName');
	this.field('title', { boost: 10 });
	this.field('text')

	documents.forEach(document => {
		this.add(document);
    });
});

/** ==================================================================
 *  Attach event listener to input
 *  ==================================================================
 */

input.addEventListener('keyup', e => {
    if (searchDelay === null) {
        determineSearchDelay();
    }

    const wait = (() => {
        return (executingFunction, waitTime) => {
            clearTimeout(timeoutHandle);
            timeoutHandle = setTimeout(executingFunction, waitTime);
        };
    })();

    wait(function () {
        search(e);
    }, searchDelay);
});

/** ==================================================================
 *  Search
 *  ==================================================================
 */

function determineSearchDelay() {
    if (index.tokenSet.toArray().length > 5000) {
        searchDelay = 300;
    } else {
        searchDelay = 0;
    }
}

function search(e) {
    const highlighter = new Mark(document.querySelector('#content'));
    const searchInput = document.querySelector('#search-input');

    searchResults.classList.add('visible');

    // begin searching when query is 2 chars
    if (searchInput.value.length > 1) {

        // highlight search terms on current page
        highlighter.unmark({
            done: function(){
                highlighter.mark(searchInput.value);
            }
        });

        const results = index.search(searchInput.value).filter(function (r) {
            return r.score > 0.0001;
        });

        if (results.length) {
            searchResults.innerHTML = '';
            let resultsList = '';

            results.forEach(result => {
                let label = result.ref.slice(0, -5);
                label = label === 'index' ? 'Home' : label;
                resultsList += `<li class="search-result" onclick="goToLocation('${result.ref}');">${label}</li>`;
            });

            // set results list HTML
            searchResults.innerHTML = resultsList;
        } else {
            searchResults.innerHTML = `<li>No Results Found for: ${searchInput.value}</li>`;
        }
    } else {
        highlighter.unmark();
        searchResults.innerHTML = '';
        searchResults.classList.remove('visible');
    }
}
