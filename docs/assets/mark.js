/*!***************************************************
 * mark.js v9.0.0
 * https://markjs.io/
 * Copyright (c) 2014–2018, Julian Kühnel
 * Released under the MIT license https://git.io/vwTVl
 *****************************************************/
!(function (e, t) {
	'object' == typeof exports && 'undefined' != typeof module
		? (module.exports = t())
		: 'function' == typeof define && define.amd
		? define(t)
		: (e.Mark = t());
})(this, function () {
	'use strict';
	function e(t) {
		return (e =
			'function' == typeof Symbol && 'symbol' == typeof Symbol.iterator
				? function (e) {
						return typeof e;
				  }
				: function (e) {
						return e &&
							'function' == typeof Symbol &&
							e.constructor === Symbol &&
							e !== Symbol.prototype
							? 'symbol'
							: typeof e;
				  })(t);
	}
	function t(e, t) {
		if (!(e instanceof t))
			throw new TypeError('Cannot call a class as a function');
	}
	function n(e, t) {
		for (var n = 0; n < t.length; n++) {
			var r = t[n];
			(r.enumerable = r.enumerable || !1),
				(r.configurable = !0),
				'value' in r && (r.writable = !0),
				Object.defineProperty(e, r.key, r);
		}
	}
	function r(e, t, r) {
		return t && n(e.prototype, t), r && n(e, r), e;
	}
	function o() {
		return (o =
			Object.assign ||
			function (e) {
				for (var t = 1; t < arguments.length; t++) {
					var n = arguments[t];
					for (var r in n)
						Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
				}
				return e;
			}).apply(this, arguments);
	}
	var i =
			/* */
			(function () {
				function e(n) {
					var r =
							!(arguments.length > 1 && void 0 !== arguments[1]) ||
							arguments[1],
						o =
							arguments.length > 2 && void 0 !== arguments[2]
								? arguments[2]
								: [],
						i =
							arguments.length > 3 && void 0 !== arguments[3]
								? arguments[3]
								: 5e3;
					t(this, e),
						(this.ctx = n),
						(this.iframes = r),
						(this.exclude = o),
						(this.iframesTimeout = i);
				}
				return (
					r(
						e,
						[
							{
								key: 'getContexts',
								value: function () {
									var e = [];
									return (
										(void 0 !== this.ctx && this.ctx
											? NodeList.prototype.isPrototypeOf(this.ctx)
												? Array.prototype.slice.call(this.ctx)
												: Array.isArray(this.ctx)
												? this.ctx
												: 'string' == typeof this.ctx
												? Array.prototype.slice.call(
														document.querySelectorAll(this.ctx)
												  )
												: [this.ctx]
											: []
										).forEach(function (t) {
											var n =
												e.filter(function (e) {
													return e.contains(t);
												}).length > 0;
											-1 !== e.indexOf(t) || n || e.push(t);
										}),
										e
									);
								}
							},
							{
								key: 'getIframeContents',
								value: function (e, t) {
									var n,
										r =
											arguments.length > 2 && void 0 !== arguments[2]
												? arguments[2]
												: function () {};
									try {
										var o = e.contentWindow;
										if (((n = o.document), !o || !n))
											throw new Error('iframe inaccessible');
									} catch (e) {
										r();
									}
									n && t(n);
								}
							},
							{
								key: 'isIframeBlank',
								value: function (e) {
									var t = 'about:blank',
										n = e.getAttribute('src').trim();
									return e.contentWindow.location.href === t && n !== t && n;
								}
							},
							{
								key: 'observeIframeLoad',
								value: function (e, t, n) {
									var r = this,
										o = !1,
										i = null,
										a = function a() {
											if (!o) {
												(o = !0), clearTimeout(i);
												try {
													r.isIframeBlank(e) ||
														(e.removeEventListener('load', a),
														r.getIframeContents(e, t, n));
												} catch (e) {
													n();
												}
											}
										};
									e.addEventListener('load', a),
										(i = setTimeout(a, this.iframesTimeout));
								}
							},
							{
								key: 'onIframeReady',
								value: function (e, t, n) {
									try {
										'complete' === e.contentWindow.document.readyState
											? this.isIframeBlank(e)
												? this.observeIframeLoad(e, t, n)
												: this.getIframeContents(e, t, n)
											: this.observeIframeLoad(e, t, n);
									} catch (e) {
										n();
									}
								}
							},
							{
								key: 'waitForIframes',
								value: function (e, t) {
									var n = this,
										r = 0;
									this.forEachIframe(
										e,
										function () {
											return !0;
										},
										function (e) {
											r++,
												n.waitForIframes(e.querySelector('html'), function () {
													--r || t();
												});
										},
										function (e) {
											e || t();
										}
									);
								}
							},
							{
								key: 'forEachIframe',
								value: function (t, n, r) {
									var o = this,
										i =
											arguments.length > 3 && void 0 !== arguments[3]
												? arguments[3]
												: function () {},
										a = t.querySelectorAll('iframe'),
										s = a.length,
										c = 0;
									a = Array.prototype.slice.call(a);
									var u = function () {
										--s <= 0 && i(c);
									};
									s || u(),
										a.forEach(function (t) {
											e.matches(t, o.exclude)
												? u()
												: o.onIframeReady(
														t,
														function (e) {
															n(t) && (c++, r(e)), u();
														},
														u
												  );
										});
								}
							},
							{
								key: 'createIterator',
								value: function (e, t, n) {
									return document.createNodeIterator(e, t, n, !1);
								}
							},
							{
								key: 'createInstanceOnIframe',
								value: function (t) {
									return new e(t.querySelector('html'), this.iframes);
								}
							},
							{
								key: 'compareNodeIframe',
								value: function (e, t, n) {
									if (
										e.compareDocumentPosition(n) &
										Node.DOCUMENT_POSITION_PRECEDING
									) {
										if (null === t) return !0;
										if (
											t.compareDocumentPosition(n) &
											Node.DOCUMENT_POSITION_FOLLOWING
										)
											return !0;
									}
									return !1;
								}
							},
							{
								key: 'getIteratorNode',
								value: function (e) {
									var t = e.previousNode();
									return {
										prevNode: t,
										node:
											null === t ? e.nextNode() : e.nextNode() && e.nextNode()
									};
								}
							},
							{
								key: 'checkIframeFilter',
								value: function (e, t, n, r) {
									var o = !1,
										i = !1;
									return (
										r.forEach(function (e, t) {
											e.val === n && ((o = t), (i = e.handled));
										}),
										this.compareNodeIframe(e, t, n)
											? (!1 !== o || i
													? !1 === o || i || (r[o].handled = !0)
													: r.push({ val: n, handled: !0 }),
											  !0)
											: (!1 === o && r.push({ val: n, handled: !1 }), !1)
									);
								}
							},
							{
								key: 'handleOpenIframes',
								value: function (e, t, n, r) {
									var o = this;
									e.forEach(function (e) {
										e.handled ||
											o.getIframeContents(e.val, function (e) {
												o.createInstanceOnIframe(e).forEachNode(t, n, r);
											});
									});
								}
							},
							{
								key: 'iterateThroughNodes',
								value: function (e, t, n, r, o) {
									for (
										var i,
											a,
											s,
											c = this,
											u = this.createIterator(t, e, r),
											l = [],
											h = [];
										(s = void 0),
											(s = c.getIteratorNode(u)),
											(a = s.prevNode),
											(i = s.node);

									)
										this.iframes &&
											this.forEachIframe(
												t,
												function (e) {
													return c.checkIframeFilter(i, a, e, l);
												},
												function (t) {
													c.createInstanceOnIframe(t).forEachNode(
														e,
														function (e) {
															return h.push(e);
														},
														r
													);
												}
											),
											h.push(i);
									h.forEach(function (e) {
										n(e);
									}),
										this.iframes && this.handleOpenIframes(l, e, n, r),
										o();
								}
							},
							{
								key: 'forEachNode',
								value: function (e, t, n) {
									var r = this,
										o =
											arguments.length > 3 && void 0 !== arguments[3]
												? arguments[3]
												: function () {},
										i = this.getContexts(),
										a = i.length;
									a || o(),
										i.forEach(function (i) {
											var s = function () {
												r.iterateThroughNodes(e, i, t, n, function () {
													--a <= 0 && o();
												});
											};
											r.iframes ? r.waitForIframes(i, s) : s();
										});
								}
							}
						],
						[
							{
								key: 'matches',
								value: function (e, t) {
									var n = 'string' == typeof t ? [t] : t,
										r =
											e.matches ||
											e.matchesSelector ||
											e.msMatchesSelector ||
											e.mozMatchesSelector ||
											e.oMatchesSelector ||
											e.webkitMatchesSelector;
									if (r) {
										var o = !1;
										return (
											n.every(function (t) {
												return !r.call(e, t) || ((o = !0), !1);
											}),
											o
										);
									}
									return !1;
								}
							}
						]
					),
					e
				);
			})(),
		a =
			/* */
			(function () {
				function e(n) {
					t(this, e),
						(this.opt = o(
							{},
							{
								diacritics: !0,
								synonyms: {},
								accuracy: 'partially',
								caseSensitive: !1,
								ignoreJoiners: !1,
								ignorePunctuation: [],
								wildcards: 'disabled'
							},
							n
						));
				}
				return (
					r(e, [
						{
							key: 'create',
							value: function (e) {
								return (
									'disabled' !== this.opt.wildcards &&
										(e = this.setupWildcardsRegExp(e)),
									(e = this.escapeStr(e)),
									Object.keys(this.opt.synonyms).length &&
										(e = this.createSynonymsRegExp(e)),
									(this.opt.ignoreJoiners ||
										this.opt.ignorePunctuation.length) &&
										(e = this.setupIgnoreJoinersRegExp(e)),
									this.opt.diacritics && (e = this.createDiacriticsRegExp(e)),
									(e = this.createMergedBlanksRegExp(e)),
									(this.opt.ignoreJoiners ||
										this.opt.ignorePunctuation.length) &&
										(e = this.createJoinersRegExp(e)),
									'disabled' !== this.opt.wildcards &&
										(e = this.createWildcardsRegExp(e)),
									(e = this.createAccuracyRegExp(e)),
									new RegExp(e, 'gm'.concat(this.opt.caseSensitive ? '' : 'i'))
								);
							}
						},
						{
							key: 'sortByLength',
							value: function (e) {
								return e.sort(function (e, t) {
									return e.length === t.length
										? e > t
											? 1
											: -1
										: t.length - e.length;
								});
							}
						},
						{
							key: 'escapeStr',
							value: function (e) {
								return e.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, '\\$&');
							}
						},
						{
							key: 'createSynonymsRegExp',
							value: function (e) {
								var t = this,
									n = this.opt.synonyms,
									r = this.opt.caseSensitive ? '' : 'i',
									o =
										this.opt.ignoreJoiners || this.opt.ignorePunctuation.length
											? '\0'
											: '';
								for (var i in n)
									if (n.hasOwnProperty(i)) {
										var a = Array.isArray(n[i]) ? n[i] : [n[i]];
										a.unshift(i),
											(a = this.sortByLength(a)
												.map(function (e) {
													return (
														'disabled' !== t.opt.wildcards &&
															(e = t.setupWildcardsRegExp(e)),
														(e = t.escapeStr(e))
													);
												})
												.filter(function (e) {
													return '' !== e;
												})).length > 1 &&
												(e = e.replace(
													new RegExp(
														'('.concat(
															a
																.map(function (e) {
																	return t.escapeStr(e);
																})
																.join('|'),
															')'
														),
														'gm'.concat(r)
													),
													o +
														'('.concat(
															a
																.map(function (e) {
																	return t.processSynonyms(e);
																})
																.join('|'),
															')'
														) +
														o
												));
									}
								return e;
							}
						},
						{
							key: 'processSynonyms',
							value: function (e) {
								return (
									(this.opt.ignoreJoiners ||
										this.opt.ignorePunctuation.length) &&
										(e = this.setupIgnoreJoinersRegExp(e)),
									e
								);
							}
						},
						{
							key: 'setupWildcardsRegExp',
							value: function (e) {
								return (e = e.replace(/(?:\\)*\?/g, function (e) {
									return '\\' === e.charAt(0) ? '?' : '';
								})).replace(/(?:\\)*\*/g, function (e) {
									return '\\' === e.charAt(0) ? '*' : '';
								});
							}
						},
						{
							key: 'createWildcardsRegExp',
							value: function (e) {
								var t = 'withSpaces' === this.opt.wildcards;
								return e
									.replace(/\u0001/g, t ? '[\\S\\s]?' : '\\S?')
									.replace(/\u0002/g, t ? '[\\S\\s]*?' : '\\S*');
							}
						},
						{
							key: 'setupIgnoreJoinersRegExp',
							value: function (e) {
								return e.replace(/[^(|)\\]/g, function (e, t, n) {
									var r = n.charAt(t + 1);
									return /[(|)\\]/.test(r) || '' === r ? e : e + '\0';
								});
							}
						},
						{
							key: 'createJoinersRegExp',
							value: function (e) {
								var t = [],
									n = this.opt.ignorePunctuation;
								return (
									Array.isArray(n) &&
										n.length &&
										t.push(this.escapeStr(n.join(''))),
									this.opt.ignoreJoiners &&
										t.push('\\u00ad\\u200b\\u200c\\u200d'),
									t.length
										? e.split(/\u0000+/).join('['.concat(t.join(''), ']*'))
										: e
								);
							}
						},
						{
							key: 'createDiacriticsRegExp',
							value: function (e) {
								var t = this.opt.caseSensitive ? '' : 'i',
									n = this.opt.caseSensitive
										? [
												'aàáảãạăằắẳẵặâầấẩẫậäåāą',
												'AÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÄÅĀĄ',
												'cçćč',
												'CÇĆČ',
												'dđď',
												'DĐĎ',
												'eèéẻẽẹêềếểễệëěēę',
												'EÈÉẺẼẸÊỀẾỂỄỆËĚĒĘ',
												'iìíỉĩịîïī',
												'IÌÍỈĨỊÎÏĪ',
												'lł',
												'LŁ',
												'nñňń',
												'NÑŇŃ',
												'oòóỏõọôồốổỗộơởỡớờợöøō',
												'OÒÓỎÕỌÔỒỐỔỖỘƠỞỠỚỜỢÖØŌ',
												'rř',
												'RŘ',
												'sšśșş',
												'SŠŚȘŞ',
												'tťțţ',
												'TŤȚŢ',
												'uùúủũụưừứửữựûüůū',
												'UÙÚỦŨỤƯỪỨỬỮỰÛÜŮŪ',
												'yýỳỷỹỵÿ',
												'YÝỲỶỸỴŸ',
												'zžżź',
												'ZŽŻŹ'
										  ]
										: [
												'aàáảãạăằắẳẵặâầấẩẫậäåāąAÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÄÅĀĄ',
												'cçćčCÇĆČ',
												'dđďDĐĎ',
												'eèéẻẽẹêềếểễệëěēęEÈÉẺẼẸÊỀẾỂỄỆËĚĒĘ',
												'iìíỉĩịîïīIÌÍỈĨỊÎÏĪ',
												'lłLŁ',
												'nñňńNÑŇŃ',
												'oòóỏõọôồốổỗộơởỡớờợöøōOÒÓỎÕỌÔỒỐỔỖỘƠỞỠỚỜỢÖØŌ',
												'rřRŘ',
												'sšśșşSŠŚȘŞ',
												'tťțţTŤȚŢ',
												'uùúủũụưừứửữựûüůūUÙÚỦŨỤƯỪỨỬỮỰÛÜŮŪ',
												'yýỳỷỹỵÿYÝỲỶỸỴŸ',
												'zžżźZŽŻŹ'
										  ],
									r = [];
								return (
									e.split('').forEach(function (o) {
										n.every(function (n) {
											if (-1 !== n.indexOf(o)) {
												if (r.indexOf(n) > -1) return !1;
												(e = e.replace(
													new RegExp('['.concat(n, ']'), 'gm'.concat(t)),
													'['.concat(n, ']')
												)),
													r.push(n);
											}
											return !0;
										});
									}),
									e
								);
							}
						},
						{
							key: 'createMergedBlanksRegExp',
							value: function (e) {
								return e.replace(/[\s]+/gim, '[\\s]+');
							}
						},
						{
							key: 'createAccuracyRegExp',
							value: function (e) {
								var t = this,
									n = this.opt.accuracy,
									r = 'string' == typeof n ? n : n.value,
									o = 'string' == typeof n ? [] : n.limiters,
									i = '';
								switch (
									(o.forEach(function (e) {
										i += '|'.concat(t.escapeStr(e));
									}),
									r)
								) {
									case 'partially':
									default:
										return '()('.concat(e, ')');
									case 'complementary':
										return (
											(i =
												'\\s' +
												(i ||
													this.escapeStr(
														'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~¡¿'
													))),
											'()([^'.concat(i, ']*').concat(e, '[^').concat(i, ']*)')
										);
									case 'exactly':
										return '(^|\\s'
											.concat(i, ')(')
											.concat(e, ')(?=$|\\s')
											.concat(i, ')');
								}
							}
						}
					]),
					e
				);
			})(),
		s =
			/* */
			(function () {
				function n(e) {
					t(this, n), (this.ctx = e), (this.ie = !1);
					var r = window.navigator.userAgent;
					(r.indexOf('MSIE') > -1 || r.indexOf('Trident') > -1) &&
						(this.ie = !0);
				}
				return (
					r(n, [
						{
							key: 'log',
							value: function (t) {
								var n =
										arguments.length > 1 && void 0 !== arguments[1]
											? arguments[1]
											: 'debug',
									r = this.opt.log;
								this.opt.debug &&
									'object' === e(r) &&
									'function' == typeof r[n] &&
									r[n]('mark.js: '.concat(t));
							}
						},
						{
							key: 'getSeparatedKeywords',
							value: function (e) {
								var t = this,
									n = [];
								return (
									e.forEach(function (e) {
										t.opt.separateWordSearch
											? e.split(' ').forEach(function (e) {
													e.trim() && -1 === n.indexOf(e) && n.push(e);
											  })
											: e.trim() && -1 === n.indexOf(e) && n.push(e);
									}),
									{
										keywords: n.sort(function (e, t) {
											return t.length - e.length;
										}),
										length: n.length
									}
								);
							}
						},
						{
							key: 'isNumeric',
							value: function (e) {
								return Number(parseFloat(e)) == e;
							}
						},
						{
							key: 'checkRanges',
							value: function (e) {
								var t = this;
								if (
									!Array.isArray(e) ||
									'[object Object]' !== Object.prototype.toString.call(e[0])
								)
									return (
										this.log(
											'markRanges() will only accept an array of objects'
										),
										this.opt.noMatch(e),
										[]
									);
								var n = [],
									r = 0;
								return (
									e
										.sort(function (e, t) {
											return e.start - t.start;
										})
										.forEach(function (e) {
											var o = t.callNoMatchOnInvalidRanges(e, r),
												i = o.start,
												a = o.end;
											o.valid &&
												((e.start = i), (e.length = a - i), n.push(e), (r = a));
										}),
									n
								);
							}
						},
						{
							key: 'callNoMatchOnInvalidRanges',
							value: function (e, t) {
								var n,
									r,
									o = !1;
								return (
									e && void 0 !== e.start
										? ((r =
												(n = parseInt(e.start, 10)) + parseInt(e.length, 10)),
										  this.isNumeric(e.start) &&
										  this.isNumeric(e.length) &&
										  r - t > 0 &&
										  r - n > 0
												? (o = !0)
												: (this.log(
														'Ignoring invalid or overlapping range: ' +
															''.concat(JSON.stringify(e))
												  ),
												  this.opt.noMatch(e)))
										: (this.log(
												'Ignoring invalid range: '.concat(JSON.stringify(e))
										  ),
										  this.opt.noMatch(e)),
									{ start: n, end: r, valid: o }
								);
							}
						},
						{
							key: 'checkWhitespaceRanges',
							value: function (e, t, n) {
								var r,
									o = !0,
									i = n.length,
									a = t - i,
									s = parseInt(e.start, 10) - a;
								return (
									(r = (s = s > i ? i : s) + parseInt(e.length, 10)) > i &&
										((r = i),
										this.log(
											'End range automatically set to the max value of '.concat(
												i
											)
										)),
									s < 0 || r - s < 0 || s > i || r > i
										? ((o = !1),
										  this.log('Invalid range: '.concat(JSON.stringify(e))),
										  this.opt.noMatch(e))
										: '' === n.substring(s, r).replace(/\s+/g, '') &&
										  ((o = !1),
										  this.log(
												'Skipping whitespace only range: ' + JSON.stringify(e)
										  ),
										  this.opt.noMatch(e)),
									{ start: s, end: r, valid: o }
								);
							}
						},
						{
							key: 'getTextNodes',
							value: function (e) {
								var t = this,
									n = '',
									r = [];
								this.iterator.forEachNode(
									NodeFilter.SHOW_TEXT,
									function (e) {
										r.push({
											start: n.length,
											end: (n += e.textContent).length,
											node: e
										});
									},
									function (e) {
										return t.matchesExclude(e.parentNode)
											? NodeFilter.FILTER_REJECT
											: NodeFilter.FILTER_ACCEPT;
									},
									function () {
										e({ value: n, nodes: r });
									}
								);
							}
						},
						{
							key: 'matchesExclude',
							value: function (e) {
								return i.matches(
									e,
									this.opt.exclude.concat([
										'script',
										'style',
										'title',
										'head',
										'html'
									])
								);
							}
						},
						{
							key: 'wrapRangeInTextNode',
							value: function (e, t, n) {
								var r = this.opt.element ? this.opt.element : 'mark',
									o = e.splitText(t),
									i = o.splitText(n - t),
									a = document.createElement(r);
								return (
									a.setAttribute('data-markjs', 'true'),
									this.opt.className &&
										a.setAttribute('class', this.opt.className),
									(a.textContent = o.textContent),
									o.parentNode.replaceChild(a, o),
									i
								);
							}
						},
						{
							key: 'wrapRangeInMappedTextNode',
							value: function (e, t, n, r, o) {
								var i = this;
								e.nodes.every(function (a, s) {
									var c = e.nodes[s + 1];
									if (void 0 === c || c.start > t) {
										if (!r(a.node)) return !1;
										var u = t - a.start,
											l = (n > a.end ? a.end : n) - a.start,
											h = e.value.substr(0, a.start),
											f = e.value.substr(l + a.start);
										if (
											((a.node = i.wrapRangeInTextNode(a.node, u, l)),
											(e.value = h + f),
											e.nodes.forEach(function (t, n) {
												n >= s &&
													(e.nodes[n].start > 0 &&
														n !== s &&
														(e.nodes[n].start -= l),
													(e.nodes[n].end -= l));
											}),
											(n -= l),
											o(a.node.previousSibling, a.start),
											!(n > a.end))
										)
											return !1;
										t = a.end;
									}
									return !0;
								});
							}
						},
						{
							key: 'wrapGroups',
							value: function (e, t, n, r) {
								return (
									r(
										(e = this.wrapRangeInTextNode(e, t, t + n)).previousSibling
									),
									e
								);
							}
						},
						{
							key: 'separateGroups',
							value: function (e, t, n, r, o) {
								for (var i = t.length, a = 1; a < i; a++) {
									var s = e.textContent.indexOf(t[a]);
									t[a] &&
										s > -1 &&
										r(t[a], e) &&
										(e = this.wrapGroups(e, s, t[a].length, o));
								}
								return e;
							}
						},
						{
							key: 'wrapMatches',
							value: function (e, t, n, r, o) {
								var i = this,
									a = 0 === t ? 0 : t + 1;
								this.getTextNodes(function (t) {
									t.nodes.forEach(function (t) {
										var o;
										for (
											t = t.node;
											null !== (o = e.exec(t.textContent)) && '' !== o[a];

										) {
											if (i.opt.separateGroups)
												t = i.separateGroups(t, o, a, n, r);
											else {
												if (!n(o[a], t)) continue;
												var s = o.index;
												if (0 !== a)
													for (var c = 1; c < a; c++) s += o[c].length;
												t = i.wrapGroups(t, s, o[a].length, r);
											}
											e.lastIndex = 0;
										}
									}),
										o();
								});
							}
						},
						{
							key: 'wrapMatchesAcrossElements',
							value: function (e, t, n, r, o) {
								var i = this,
									a = 0 === t ? 0 : t + 1;
								this.getTextNodes(function (t) {
									for (var s; null !== (s = e.exec(t.value)) && '' !== s[a]; ) {
										var c = s.index;
										if (0 !== a) for (var u = 1; u < a; u++) c += s[u].length;
										var l = c + s[a].length;
										i.wrapRangeInMappedTextNode(
											t,
											c,
											l,
											function (e) {
												return n(s[a], e);
											},
											function (t, n) {
												(e.lastIndex = n), r(t);
											}
										);
									}
									o();
								});
							}
						},
						{
							key: 'wrapRangeFromIndex',
							value: function (e, t, n, r) {
								var o = this;
								this.getTextNodes(function (i) {
									var a = i.value.length;
									e.forEach(function (e, r) {
										var s = o.checkWhitespaceRanges(e, a, i.value),
											c = s.start,
											u = s.end;
										s.valid &&
											o.wrapRangeInMappedTextNode(
												i,
												c,
												u,
												function (n) {
													return t(n, e, i.value.substring(c, u), r);
												},
												function (t) {
													n(t, e);
												}
											);
									}),
										r();
								});
							}
						},
						{
							key: 'unwrapMatches',
							value: function (e) {
								for (
									var t = e.parentNode, n = document.createDocumentFragment();
									e.firstChild;

								)
									n.appendChild(e.removeChild(e.firstChild));
								t.replaceChild(n, e),
									this.ie ? this.normalizeTextNode(t) : t.normalize();
							}
						},
						{
							key: 'normalizeTextNode',
							value: function (e) {
								if (e) {
									if (3 === e.nodeType)
										for (; e.nextSibling && 3 === e.nextSibling.nodeType; )
											(e.nodeValue += e.nextSibling.nodeValue),
												e.parentNode.removeChild(e.nextSibling);
									else this.normalizeTextNode(e.firstChild);
									this.normalizeTextNode(e.nextSibling);
								}
							}
						},
						{
							key: 'markRegExp',
							value: function (e, t) {
								var n = this;
								(this.opt = t),
									this.log('Searching with expression "'.concat(e, '"'));
								var r = 0,
									o = 'wrapMatches';
								this.opt.acrossElements && (o = 'wrapMatchesAcrossElements'),
									this[o](
										e,
										this.opt.ignoreGroups,
										function (e, t) {
											return n.opt.filter(t, e, r);
										},
										function (e) {
											r++, n.opt.each(e);
										},
										function () {
											0 === r && n.opt.noMatch(e), n.opt.done(r);
										}
									);
							}
						},
						{
							key: 'mark',
							value: function (e, t) {
								var n = this;
								this.opt = t;
								var r = 0,
									o = 'wrapMatches',
									i = this.getSeparatedKeywords('string' == typeof e ? [e] : e),
									s = i.keywords,
									c = i.length;
								this.opt.acrossElements && (o = 'wrapMatchesAcrossElements'),
									0 === c
										? this.opt.done(r)
										: (function e(t) {
												var i = new a(n.opt).create(t),
													u = 0;
												n.log('Searching with expression "'.concat(i, '"')),
													n[o](
														i,
														1,
														function (e, o) {
															return n.opt.filter(o, t, r, u);
														},
														function (e) {
															u++, r++, n.opt.each(e);
														},
														function () {
															0 === u && n.opt.noMatch(t),
																s[c - 1] === t
																	? n.opt.done(r)
																	: e(s[s.indexOf(t) + 1]);
														}
													);
										  })(s[0]);
							}
						},
						{
							key: 'markRanges',
							value: function (e, t) {
								var n = this;
								this.opt = t;
								var r = 0,
									o = this.checkRanges(e);
								o && o.length
									? (this.log(
											'Starting to mark with the following ranges: ' +
												JSON.stringify(o)
									  ),
									  this.wrapRangeFromIndex(
											o,
											function (e, t, r, o) {
												return n.opt.filter(e, t, r, o);
											},
											function (e, t) {
												r++, n.opt.each(e, t);
											},
											function () {
												n.opt.done(r);
											}
									  ))
									: this.opt.done(r);
							}
						},
						{
							key: 'unmark',
							value: function (e) {
								var t = this;
								this.opt = e;
								var n = this.opt.element ? this.opt.element : '*';
								(n += '[data-markjs]'),
									this.opt.className && (n += '.'.concat(this.opt.className)),
									this.log('Removal selector "'.concat(n, '"')),
									this.iterator.forEachNode(
										NodeFilter.SHOW_ELEMENT,
										function (e) {
											t.unwrapMatches(e);
										},
										function (e) {
											var r = i.matches(e, n),
												o = t.matchesExclude(e);
											return !r || o
												? NodeFilter.FILTER_REJECT
												: NodeFilter.FILTER_ACCEPT;
										},
										this.opt.done
									);
							}
						},
						{
							key: 'opt',
							set: function (e) {
								this._opt = o(
									{},
									{
										element: '',
										className: '',
										exclude: [],
										iframes: !1,
										iframesTimeout: 5e3,
										separateWordSearch: !0,
										acrossElements: !1,
										ignoreGroups: 0,
										each: function () {},
										noMatch: function () {},
										filter: function () {
											return !0;
										},
										done: function () {},
										debug: !1,
										log: window.console
									},
									e
								);
							},
							get: function () {
								return this._opt;
							}
						},
						{
							key: 'iterator',
							get: function () {
								return new i(
									this.ctx,
									this.opt.iframes,
									this.opt.exclude,
									this.opt.iframesTimeout
								);
							}
						}
					]),
					n
				);
			})();
	return function (e) {
		var t = this,
			n = new s(e);
		return (
			(this.mark = function (e, r) {
				return n.mark(e, r), t;
			}),
			(this.markRegExp = function (e, r) {
				return n.markRegExp(e, r), t;
			}),
			(this.markRanges = function (e, r) {
				return n.markRanges(e, r), t;
			}),
			(this.unmark = function (e) {
				return n.unmark(e), t;
			}),
			this
		);
	};
});