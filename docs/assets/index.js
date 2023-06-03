// ==================================================================
// #region Constants / DOM lifecycle hooks
// ==================================================================

const
	SCOPES = ['global', 'public', 'private', 'protected', 'testMethod', 'webService'],
	MENU_STATE_KEY = 'APEXDOX_MENU',
	ACTIVE_EL_STATE_KEY = 'APEXDOX_ACTIVE_EL',
	SCOPE_STATE_KEY = 'APEXDOX_SCOPE',
	SEARCH_STATE_KEY = 'APEXDOX_SEARCH_RESULTS';

const apexJsSelectors = [
	'.method-annotations',
	'.class-signature',
	'.attribute-signature',
	'.method-signature',
	'.class-annotations',
	'.prop-annotations'
];

const initializers = [
	initMenu,
	initHighlightJs,
	renderMenuFromState,
	setActiveElement,
	renderSearchFromState,
	readScope,
	hideAllScopes,
	showScopes
];

const persisters = [
	persistMenuState,
	persistActiveElement,
	persistSearchState
];

const executeAll = funcs => funcs.forEach(func => func());

document.addEventListener('DOMContentLoaded', () => {
	executeAll(initializers);
});

window.onbeforeunload = () => {
	executeAll(persisters);
}

// #endregion
// ==================================================================


// ==================================================================
// #region Initialization & Menu Utils, local state
// ==================================================================

function initHighlightJs() {
	apexJsSelectors.forEach((selector) => {
		document.querySelectorAll(selector).forEach(block => {
			block.classList.add("language-apex");
		});
	});
	// Alow language auto-detection in "pre code" blocks
	apexJsSelectors.push("pre code");
	// initialize highlighting for code examples and
	// signatures for methods, classes, props and enums
	// Highlight.js now contains multiple languages to aid in
	// code highlighting for the HTML pages in documentation
	// Bash, CSS, JSON, YAML, Markdown, HTML/Visualforce, JavaScript, Plain Text)
	hljs.configure({
		cssSelector: apexJsSelectors
	});
	hljs.highlightAll();
}

// create session storage object for menu state
// and/or update state with any new menu items
function initMenu() {
	const hasState = sessionStorage.getItem(MENU_STATE_KEY);
	let items = document.querySelectorAll('.group-name');
	let state = !hasState ? {} : JSON.parse(hasState);

	if (!hasState) {
		// initialize menu state
		console.log('ApexDox: initializing menu state');
		items.forEach(item => state[item.id] = false);
	} else {
		// If already init, add any new class groups since last load.
		// should really only happen when docs are under development
		updateMenuModel(items, state);
	}

	// finally, update sessionStorage with latest state
	sessionStorage.setItem(MENU_STATE_KEY, JSON.stringify(state));
}

function updateMenuModel(items, state) {
	// 1) get keys currently in state object
	let keys = Object.keys(state);

	// 2) get ids from each .group-name <details> element
	let groups = Array.prototype.map.call(items, item => ({
		id: item.id,
		isOpen: item.getAttribute('open')
	}));

	// 3) perform diff to get Ids not yet captured in storage
	let deletedKeys = keys.filter(key =>
		groups.findIndex(group => group.id === key) === -1);

	let newKeys = groups.filter(item => keys.indexOf(item.id) === -1);

	// 4) add/delete keys to/from state
	if (deletedKeys.length > 0) {
		deletedKeys.forEach(key => {
			delete state[key];
		});
		console.log('ApexDox: Stale menu keys found, deleting from session storage:');
		console.log(deletedKeys);
	}

	if (newKeys.length > 0) {
		newKeys.forEach(item => state[item.id] = item.isOpen === '' && true);
		console.log('ApexDox: New menu keys found, adding to session storage:');
		console.log(newKeys.map(function (g) { return g.id }));
	}
}

function renderMenuFromState() {
	let state = JSON.parse(sessionStorage.getItem(MENU_STATE_KEY));
	if (state) {
		for (let group in state) {
			let item = document.getElementById(group);
			if (state[group]) {
				console.log('ApexDox: Opening ' + group + ' section');
				item.setAttribute('open', '');
			}
		}
	}
}

// save menu state before each unload so that state is
// preserved when changing files or when reloading the page.
function persistMenuState() {
	let items = document.querySelectorAll('.group-name');
	let state = JSON.parse(sessionStorage.getItem(MENU_STATE_KEY));

	items.forEach(item => {
		let isOpen = item.getAttribute('open');
		console.log(isOpen);
		state[item.id] = isOpen === '' && true;
	});

	sessionStorage.setItem(MENU_STATE_KEY, JSON.stringify(state));
}

// preserve active menu item across loads
function persistActiveElement() {
	let active = document.querySelector('.active');
	if (active) {
		sessionStorage.setItem(ACTIVE_EL_STATE_KEY, active.id);
	} else {
		sessionStorage.removeItem(ACTIVE_EL_STATE_KEY);
	}
}

// set active element from storage
function setActiveElement() {
	const id = sessionStorage.getItem(ACTIVE_EL_STATE_KEY);
	if (id) {
		var item = document.getElementById(id);
		item.classList.add('active');
		// focus element as well so tab
		// navigation can pick up where it left off
		if (item.firstElementChild && item.firstElementChild.tagName === 'A') {
			item.firstElementChild.focus();
		} else {
			item.focus();
		}
	}
}

// persist any search results across loads
function persistSearchState() {
	const searchTerm = document.querySelector('#search-input').value;
	const resultsMarkup = document.querySelector('#search-results').innerHTML

	if (searchTerm.length > 1) {
		const searchState = JSON.stringify({
			searchTerm,
			resultsMarkup
		});

		sessionStorage.setItem(SEARCH_STATE_KEY, searchState);
	} else {
		sessionStorage.removeItem(SEARCH_STATE_KEY);
	}
}

// preserve active menu item across loads
function renderSearchFromState() {
	const state = JSON.parse(sessionStorage.getItem(SEARCH_STATE_KEY));

	if (state) {
		const searchResults = document.querySelector('#search-results');
		const searchInput = document.querySelector('#search-input');

		searchInput.value = state.searchTerm;
		searchResults.classList.add('visible');
		searchResults.classList.add('no-transition');
		searchResults.innerHTML = state.resultsMarkup;

		// remove class which prevents transition on page move
		setTimeout(() => searchResults.classList.remove('no-transition'), 100);
	}
}

// #endregion
// ==================================================================


// ==================================================================
// #region Scope Utils
// ==================================================================

function getListScope() {
	let list = [];
	let checkboxes = document.querySelectorAll('input[type=checkbox]');
	checkboxes.forEach(checkbox => {
		if (checkbox.checked && checkbox.id !== 'cbx-all') {
			let str = checkbox.id;
			str = str.replace('cbx-', '');
			list.push(str);
		}
	});
	return list;
}

function showScopes() {
	let list = getListScope();
	for (let i = 0; i < list.length; i++) {
		toggleScope(list[i], true);
	}
}

function showAllScopes() {
	for (let i = 0; i < SCOPES.length; i++) {
		toggleScope(SCOPES[i], true);
	}
}

function hideAllScopes() {
	for (let i = 0; i < SCOPES.length; i++) {
		toggleScope(SCOPES[i], false);
	}
}

function setScope() {
	const list = getListScope();
	const scopes = list.join(',');
	sessionStorage.setItem(SCOPE_STATE_KEY, scopes);
	shouldCheckAll(list);
}

function readScope() {
	const strScope = getScope();
	if (strScope != null && strScope != '') {

		// first clear all the scope checkboxes
		let checkboxes = document.querySelectorAll('input[type=checkbox]');
		checkboxes.forEach(checkbox => checkbox.removeAttribute('checked'));

		// now check the appropriate scope checkboxes
		let list = strScope.split(',');
		for (let i = 0; i < list.length; i++) {
			let id = 'cbx-' + list[i];
			let checkbox = document.getElementById(id);
			checkbox.setAttribute('checked', true);
		}

		// check the all box if all scopes have are active
		shouldCheckAll(list);
	} else {
		showAllScopes();
	}
}

function getScope() {
	const scope = sessionStorage.getItem(SCOPE_STATE_KEY);
	return scope ? scope : '';
}

function shouldCheckAll(list) {
	const checkboxes = document.querySelectorAll('input[type=checkbox]');

	let allBox = document.getElementById('cbx-all');

	if (checkboxes.length - 1 === list.length) {
		allBox.setAttribute('checked', true);
	} else {
		allBox.removeAttribute('checked');
	}
}

function toggleScope(scope, isShow) {
	setScope();
	toggleTypeScope(scope, '.properties', '.property', isShow);
	toggleTypeScope(scope, '.enums', '.enum', isShow);
	toggleTypeScope(scope, '.methods', '.method', isShow);
	toggleTypeScope(scope, null, '.class', isShow);
}

function toggleTypeScope(scope, tableSelector, itemSelector, isShow) {
	const tables = tableSelector ? document.querySelectorAll(tableSelector) : null;
	const items = document.querySelectorAll(`${itemSelector}.${scope}`);

	if (isShow === true) {
		if (tables && items.length) { // show tables if they've been hidden
			toggleVisibility(tables, true);
		}
		toggleVisibility(items, true);
	} else {
		toggleVisibility(items, false);
		maybeHideElement(tableSelector, itemSelector); // hide tables if all its rows have been hidden
	}
}

function toggleVisibility(elements, isShow) {
	for (let elem of elements) {
		if (isShow) {
			elem.classList.remove('hide');
		} else {
			elem.classList.add('hide');
		}
	}
}

function maybeHideElement(toHide, itemSelector) {
	let elements, container = document.querySelectorAll(toHide);
	if (elements = document.querySelectorAll(itemSelector)) {
		for (let element of elements) {
			if (!element.classList.contains('hide')) {
				return;
			}
		}
		toggleVisibility(container, false);
	}
}

function toggleActiveClass(elem) {
	// remove isActive from current active element
	let item = document.querySelector('.active');
	item && item.classList.remove('active');

	// add to new active element
	elem && elem.classList.add('active');
}

// #endregion
// ==================================================================


// ==================================================================
// #region Global Functions
// ==================================================================

window.goToLocation = (url) => {
	// prevent collapsing / expanding menu
	// when clicking on Class Group link
	event.preventDefault();

	// handle menu navigation
	if (event.currentTarget.classList.contains('nav-item')) {
		toggleActiveClass(event.currentTarget);
	} else {
		const target = document.querySelector(`#item-${url.replace('.html', '')}`);
		if (target) {
			toggleActiveClass(target);
			const details = document.querySelectorAll('details');
			const parentDetail = target.parentNode.previousElementSibling.parentNode;

			// when navigating from search, open target
			// details element and close all the others.
			for (let detail of details) {
				if (detail !== parentDetail) {
					detail.removeAttribute('open');
				} else {
					parentDetail.setAttribute('open', ''); // same as true
				}
			}
		} else {
			toggleActiveClass();
		}
	}

	document.location.href = url;
}

window.toggleAllScopes = (isShow) => {
	const checkboxes = document.querySelectorAll('input[type=checkbox]');
	// NOTE: for some reason, just checking or un-checking the checkboxes
	// via attribute and then using hideAllScopes or showAllScopes wasn't
	// working as expected, use click() to trigger the onclick funcs instead.
	checkboxes.forEach(checkbox => {
		if (checkbox.id !== 'cbx-all') {
			if (isShow && !checkbox.checked) {
				checkbox.click();
			} else if (!isShow && checkbox.checked) {
				checkbox.click();
			}
		}
	});
}

window.toggleScope = (scope, isShow) => {
	toggleScope(scope, isShow);
}

// #endregion
// ==================================================================