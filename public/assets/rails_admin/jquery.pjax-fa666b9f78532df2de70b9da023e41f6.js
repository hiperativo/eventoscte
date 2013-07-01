!function(t){function e(e,r,n){var o=this;return this.on("click.pjax",e,function(e){var i=t.extend({},d(r,n));i.container||(i.container=t(this).attr("data-pjax")||o),a(e,i)})}function a(e,a,r){r=d(a,r);var o=e.currentTarget;if("A"!==o.tagName.toUpperCase())throw"$.fn.pjax or $.pjax.click requires an anchor element";if(!(e.which>1||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey||location.protocol!==o.protocol||location.host!==o.host||o.hash&&o.href.replace(o.hash,"")===location.href.replace(location.hash,"")||o.href===location.href+"#")){var i={url:o.href,container:t(o).attr("data-pjax"),target:o,fragment:null};n(t.extend({},i,r)),e.preventDefault()}}function r(e,a,r){r=d(a,r);var o=e.currentTarget;if("FORM"!==o.tagName.toUpperCase())throw"$.pjax.submit requires a form element";var i={type:o.method,url:o.action,data:t(o).serializeArray(),container:t(o).attr("data-pjax"),target:o,fragment:null};n(t.extend({},i,r)),e.preventDefault()}function n(e){function a(e,a){var n=t.Event(e,{relatedTarget:r});return l.trigger(n,a),!n.isDefaultPrevented()}e=t.extend(!0,{},t.ajaxSettings,n.defaults,e),t.isFunction(e.url)&&(e.url=e.url());var r=e.target,o=p(e.url).hash,l=e.context=f(e.container);e.data||(e.data={}),e.data._pjax=l.selector;var c;e.beforeSend=function(t,r){return"GET"!==r.type&&(r.timeout=0),t.setRequestHeader("X-PJAX","true"),t.setRequestHeader("X-PJAX-Container",l.selector),a("pjax:beforeSend",[t,r])?(r.timeout>0&&(c=setTimeout(function(){a("pjax:timeout",[t,e])&&t.abort("timeout")},r.timeout),r.timeout=0),e.requestUrl=p(r.url).href,void 0):!1},e.complete=function(t,r){c&&clearTimeout(c),a("pjax:complete",[t,r,e]),a("pjax:end",[t,e])},e.error=function(t,r,n){var o=m("",t,e),l=a("pjax:error",[t,r,n,e]);"GET"==e.type&&"abort"!==r&&l&&i(o.url)},e.success=function(r,c,u){var d=m(r,u,e);if(!d.contents)return i(d.url),void 0;if(n.state={id:e.id||s(),url:d.url,title:d.title,container:l.selector,fragment:e.fragment,timeout:e.timeout},(e.push||e.replace)&&window.history.replaceState(n.state,d.title,d.url),d.title&&(document.title=d.title),l.html(d.contents),"number"==typeof e.scrollTo&&t(window).scrollTop(e.scrollTo),(e.replace||e.push)&&window._gaq&&_gaq.push(["_trackPageview"]),""!==o){var f=p(d.url);f.hash=o,n.state.url=f.href,window.history.replaceState(n.state,d.title,f.href);var h=t(f.hash);h.length&&t(window).scrollTop(h.offset().top)}a("pjax:success",[r,c,u,e])},n.state||(n.state={id:s(),url:window.location.href,title:document.title,container:l.selector,fragment:e.fragment,timeout:e.timeout},window.history.replaceState(n.state,document.title));var d=n.xhr;d&&d.readyState<4&&(d.onreadystatechange=t.noop,d.abort()),n.options=e;var d=n.xhr=t.ajax(e);return d.readyState>0&&(e.push&&!e.replace&&(x(n.state.id,l.clone().contents()),window.history.pushState(null,"",u(e.requestUrl))),a("pjax:start",[d,e]),a("pjax:send",[d,e])),n.xhr}function o(e,a){var r={url:window.location.href,push:!1,replace:!0,scrollTo:!1};return n(t.extend(r,d(e,a)))}function i(t){window.history.replaceState(null,"","#"),window.location.replace(t)}function l(e){var a=e.state;if(a&&a.container){var r=t(a.container);if(r.length){var o=w[a.id];if(!n.state)return n.state=a,void 0;var l=n.state.id<a.id?"forward":"back";v(l,n.state.id,r.clone().contents());var c=t.Event("pjax:popstate",{state:a,direction:l});r.trigger(c);var s={id:a.id,url:a.url,container:r,push:!1,fragment:a.fragment,timeout:a.timeout,scrollTo:!1};o?(r.trigger("pjax:start",[null,s]),a.title&&(document.title=a.title),r.html(o),n.state=a,r.trigger("pjax:end",[null,s])):n(s),r[0].offsetHeight}else i(location.href)}}function c(e){var a=t.isFunction(e.url)?e.url():e.url,r=e.type?e.type.toUpperCase():"GET",n=t("<form>",{method:"GET"===r?"GET":"POST",action:a,style:"display:none"});"GET"!==r&&"POST"!==r&&n.append(t("<input>",{type:"hidden",name:"_method",value:r.toLowerCase()}));var o=e.data;if("string"==typeof o)t.each(o.split("&"),function(e,a){var r=a.split("=");n.append(t("<input>",{type:"hidden",name:r[0],value:r[1]}))});else if("object"==typeof o)for(key in o)n.append(t("<input>",{type:"hidden",name:key,value:o[key]}));t(document.body).append(n),n.submit()}function s(){return(new Date).getTime()}function u(t){return t.replace(/\?_pjax=[^&]+&?/,"?").replace(/_pjax=[^&]+&?/,"").replace(/[\?&]$/,"")}function p(t){var e=document.createElement("a");return e.href=t,e}function d(e,a){return e&&a?a.container=e:a=t.isPlainObject(e)?e:{container:e},a.container&&(a.container=f(a.container)),a}function f(e){if(e=t(e),e.length){if(""!==e.selector&&e.context===document)return e;if(e.attr("id"))return t("#"+e.attr("id"));throw"cant get selector for pjax container!"}throw"no pjax container for "+e.selector}function h(t,e){return t.filter(e).add(t.find(e))}function m(e,a,r){var n={};if(n.url=u(a.getResponseHeader("X-PJAX-URL")||r.requestUrl),/<html/i.test(e))var o=t(e.match(/<head[^>]*>([\s\S.]*)<\/head>/i)[0]),i=t(e.match(/<body[^>]*>([\s\S.]*)<\/body>/i)[0]);else var o=i=t(e);if(0===i.length)return n;if(n.title=h(o,"title").last().text(),r.fragment){if("body"===r.fragment)var l=i;else var l=h(i,r.fragment).first();l.length&&(n.contents=l.contents(),n.title||(n.title=l.attr("title")||l.data("title")))}else/<html/i.test(e)||(n.contents=i);return n.contents&&(n.contents=n.contents.not("title"),n.contents.find("title").remove()),n.title&&(n.title=t.trim(n.title)),n}function x(t,e){for(w[t]=e,b.push(t);y.length;)delete w[y.shift()];for(;b.length>n.defaults.maxCacheLength;)delete w[b.shift()]}function v(t,e,a){var r,n;w[e]=a,"forward"===t?(r=b,n=y):(r=y,n=b),r.push(e),(e=n.pop())&&delete w[e]}function g(){t.fn.pjax=e,t.pjax=n,t.pjax.enable=t.noop,t.pjax.disable=j,t.pjax.click=a,t.pjax.submit=r,t.pjax.reload=o,t.pjax.defaults={timeout:650,push:!0,replace:!1,type:"GET",dataType:"html",scrollTo:0,maxCacheLength:20},t(window).bind("popstate.pjax",l)}function j(){t.fn.pjax=function(){return this},t.pjax=c,t.pjax.enable=g,t.pjax.disable=t.noop,t.pjax.click=t.noop,t.pjax.submit=t.noop,t.pjax.reload=function(){window.location.reload()},t(window).unbind("popstate.pjax",l)}var w={},y=[],b=[];t.inArray("state",t.event.props)<0&&t.event.props.push("state"),t.support.pjax=window.history&&window.history.pushState&&window.history.replaceState&&!navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]|WebApps\/.+CFNetwork)/),t.support.pjax?g():j()}(jQuery);