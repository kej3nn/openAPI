!/**
 * Highcharts JS v11.4.0 (2024-03-04)
 *
 * Exporting module
 *
 * (c) 2010-2024 Torstein Honsi
 *
 * License: www.highcharts.com/license
 */function(t){"object"==typeof module&&module.exports?(t.default=t,module.exports=t):"function"==typeof define&&define.amd?define("highcharts/modules/export-data",["highcharts","highcharts/modules/exporting"],function(e){return t(e),t.Highcharts=e,t}):t("undefined"!=typeof Highcharts?Highcharts:void 0)}(function(t){"use strict";var e=t?t._modules:{};function a(t,e,a,o){t.hasOwnProperty(e)||(t[e]=o.apply(null,a),"function"==typeof CustomEvent&&window.dispatchEvent(new CustomEvent("HighchartsModuleLoaded",{detail:{path:e,module:t[e]}})))}a(e,"Extensions/DownloadURL.js",[e["Core/Globals.js"]],function(t){var e=t.isSafari,a=t.win,o=t.win.document,n=a.URL||a.webkitURL||a;function i(t){var e=t.replace(/filename=.*;/,"").match(/data:([^;]*)(;base64)?,([0-9A-Za-z+/]+)/);if(e&&e.length>3&&a.atob&&a.ArrayBuffer&&a.Uint8Array&&a.Blob&&n.createObjectURL){for(var o=a.atob(e[3]),i=new a.ArrayBuffer(o.length),r=new a.Uint8Array(i),s=0;s<r.length;++s)r[s]=o.charCodeAt(s);return n.createObjectURL(new a.Blob([r],{type:e[1]}))}}return{dataURLtoBlob:i,downloadURL:function(t,n){var r=a.navigator,s=o.createElement("a");if("string"!=typeof t&&!(t instanceof String)&&r.msSaveOrOpenBlob){r.msSaveOrOpenBlob(t,n);return}t=""+t;var l=/Edge\/\d+/.test(r.userAgent);if((e&&"string"==typeof t&&0===t.indexOf("data:application/pdf")||l||t.length>2e6)&&!(t=i(t)||""))throw Error("Failed to convert to blob");if(void 0!==s.download)s.href=t,s.download=n,o.body.appendChild(s),s.click(),o.body.removeChild(s);else try{if(!a.open(t,"chart"))throw Error("Failed to open window")}catch(e){a.location.href=t}}}}),a(e,"Extensions/ExportData/ExportDataDefaults.js",[],function(){return{exporting:{csv:{annotations:{itemDelimiter:"; ",join:!1},columnHeaderFormatter:null,dateFormat:"%Y-%m-%d %H:%M:%S",decimalPoint:null,itemDelimiter:null,lineDelimiter:"\n"},showTable:!1,useMultiLevelHeaders:!0,useRowspanHeaders:!0,showExportInProgress:!0},lang:{downloadCSV:"Download CSV",downloadXLS:"Download XLS",exportData:{annotationHeader:"Annotations",categoryHeader:"Category",categoryDatetimeHeader:"DateTime"},viewData:"View data table",hideData:"Hide data table",exportInProgress:"Exporting..."}}}),a(e,"Extensions/ExportData/ExportData.js",[e["Core/Renderer/HTML/AST.js"],e["Core/Defaults.js"],e["Extensions/DownloadURL.js"],e["Extensions/ExportData/ExportDataDefaults.js"],e["Core/Globals.js"],e["Core/Utilities.js"]],function(t,e,a,o,n,i){var r=this&&this.__spreadArray||function(t,e,a){if(a||2==arguments.length)for(var o,n=0,i=e.length;n<i;n++)!o&&n in e||(o||(o=Array.prototype.slice.call(e,0,n)),o[n]=e[n]);return t.concat(o||Array.prototype.slice.call(e))},s=e.getOptions,l=e.setOptions,c=a.downloadURL,d=n.doc,h=n.win,p=i.addEvent,u=i.defined,f=i.extend,m=i.find,g=i.fireEvent,x=i.isNumber,v=i.pick;function b(t){var e,a=this,o=!!(null===(e=this.options.exporting)||void 0===e?void 0:e.showExportInProgress),n=h.requestAnimationFrame||setTimeout;n(function(){o&&a.showLoading(a.options.lang.exportInProgress),n(function(){try{t.call(a)}finally{o&&a.hideLoading()}})})}function y(){var t=this;b.call(this,function(){var e=t.getCSV(!0);c(R(e,"text/csv")||"data:text/csv,\uFEFF"+encodeURIComponent(e),t.getFilename()+".csv")})}function w(){var t=this;b.call(this,function(){var e='<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>Ark1</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><style>td{border:none;font-family: Calibri, sans-serif;} .number{mso-number-format:"0.00";} .text{ mso-number-format:"@";}</style><meta name=ProgId content=Excel.Sheet><meta charset=UTF-8></head><body>'+t.getTable(!0)+"</body></html>";c(R(e,"application/vnd.ms-excel")||"data:application/vnd.ms-excel;base64,"+h.btoa(unescape(encodeURIComponent(e))),t.getFilename()+".xls")})}function D(t){var e="",a=this.getDataRows(),o=this.options.exporting.csv,n=v(o.decimalPoint,","!==o.itemDelimiter&&t?1.1.toLocaleString()[1]:"."),i=v(o.itemDelimiter,","===n?";":","),r=o.lineDelimiter;return a.forEach(function(t,o){for(var s="",l=t.length;l--;)"string"==typeof(s=t[l])&&(s='"'.concat(s,'"')),"number"==typeof s&&"."!==n&&(s=s.toString().replace(".",n)),t[l]=s;t.length=a.length?a[0].length:0,e+=t.join(i),o<a.length-1&&(e+=r)}),e}function T(t){var e,a,o,n,i,s,l,c=this.hasParallelCoordinates,d=this.time,h=this.options.exporting&&this.options.exporting.csv||{},p=this.xAxis,f={},b=[],y=[],w=[],D=this.options.lang.exportData,T=D.categoryHeader,E=D.categoryDatetimeHeader,L=function(e,a,o){if(h.columnHeaderFormatter){var n=h.columnHeaderFormatter(e,a,o);if(!1!==n)return n}return e?e.bindAxes?t?{columnTitle:o>1?a:e.name,topLevelColumnTitle:e.name}:e.name+(o>1?" ("+a+")":""):e.options.title&&e.options.title.text||(e.dateTime?E:T):T},S=function(t,e,a){var o={},n={};return e.forEach(function(e){var i=(t.keyToAxis&&t.keyToAxis[e]||e)+"Axis",r=x(a)?t.chart[i][a]:t[i];o[e]=r&&r.categories||[],n[e]=r&&r.dateTime}),{categoryMap:o,dateTimeValueAxisMap:n}},C=function(t,e){var a=t.pointArrayMap||["y"];return t.data.some(function(t){return void 0!==t.y&&t.name})&&e&&!e.categories&&"name"!==t.exportKey?r(["x"],a,!0):a},A=[],R=0;for(s in this.series.forEach(function(e){var a,o,n=e.options.keys,r=e.xAxis,s=n||C(e,r),l=s.length,u=!e.requireSorting&&{},g=p.indexOf(r),x=S(e,s);if(!1!==e.options.includeInDataExport&&!e.options.isInternal&&!1!==e.visible){for(m(A,function(t){return t[0]===g})||A.push([g,R]),o=0;o<l;)i=L(e,s[o],s.length),w.push(i.columnTitle||i),t&&y.push(i.topLevelColumnTitle||i),o++;a={chart:e.chart,autoIncrement:e.autoIncrement,options:e.options,pointArrayMap:e.pointArrayMap,index:e.index},e.options.data.forEach(function(t,n){var i,p,m,b,y={series:a};c&&(x=S(e,s,n)),e.pointClass.prototype.applyOptions.apply(y,[t]);var w=e.data[n]&&e.data[n].name;if(p=(null!==(i=y.x)&&void 0!==i?i:"")+","+w,o=0,(!r||"name"===e.exportKey||!c&&r&&r.hasNames&&w)&&(p=w),u&&(u[p]&&(p+="|"+n),u[p]=!0),f[p]){var D="".concat(p,",").concat(f[p].pointers[e.index]),T=p;f[p].pointers[e.index]&&(f[D]||(f[D]=[],f[D].xValues=[],f[D].pointers=[]),p=D),f[T].pointers[e.index]+=1}else{f[p]=[],f[p].xValues=[];for(var E=[],L=0;L<e.chart.series.length;L++)E[L]=0;f[p].pointers=E,f[p].pointers[e.index]=1}for(f[p].x=y.x,f[p].name=w,f[p].xValues[g]=y.x;o<l;)b=y[m=s[o]],f[p][R+o]=v(x.categoryMap[m][b],x.dateTimeValueAxisMap[m]?d.dateFormat(h.dateFormat,b):null,b),o++}),R+=o}}),f)Object.hasOwnProperty.call(f,s)&&b.push(f[s]);for(n=t?[y,w]:[w],R=A.length;R--;)e=A[R][0],a=A[R][1],o=p[e],b.sort(function(t,a){return t.xValues[e]-a.xValues[e]}),l=L(o),n[0].splice(a,0,l),t&&n[1]&&n[1].splice(a,0,l),b.forEach(function(t){var e=t.name;o&&!u(e)&&(o.dateTime?(t.x instanceof Date&&(t.x=t.x.getTime()),e=d.dateFormat(h.dateFormat,t.x)):e=o.categories?v(o.names[t.x],o.categories[t.x],t.x):t.x),t.splice(a,0,e)});return g(this,"exportData",{dataRows:n=n.concat(b)}),n}function E(t){var e=function(t){if(!t.tagName||"#text"===t.tagName)return t.textContent||"";var a=t.attributes,o="<".concat(t.tagName);return a&&Object.keys(a).forEach(function(t){var e=a[t];o+=" ".concat(t,'="').concat(e,'"')}),o+=">"+(t.textContent||""),(t.children||[]).forEach(function(t){o+=e(t)}),o+="</".concat(t.tagName,">")};return e(this.getTableAST(t))}function L(t){var e=0,a=[],o=this.options,n=t?1.1.toLocaleString()[1]:".",i=v(o.exporting.useMultiLevelHeaders,!0),r=this.getDataRows(i),s=i?r.shift():null,l=r.shift(),c=function(t,e){var a=t.length;if(e.length!==a)return!1;for(;a--;)if(t[a]!==e[a])return!1;return!0},d=function(t,e,a,o){var i=v(o,""),r="highcharts-text"+(e?" "+e:"");return"number"==typeof i?(i=i.toString(),","===n&&(i=i.replace(".",n)),r="highcharts-number"):o||(r="highcharts-empty"),{tagName:t,attributes:a=f({class:r},a),textContent:i}};!1!==o.exporting.tableCaption&&a.push({tagName:"caption",attributes:{class:"highcharts-table-caption"},textContent:v(o.exporting.tableCaption,o.title.text?o.title.text:"Chart")});for(var h=0,p=r.length;h<p;++h)r[h].length>e&&(e=r[h].length);a.push(function(t,e,a){var n,r,s=[],l=0,h=a||e&&e.length,p=0;if(i&&t&&e&&!c(t,e)){for(var u=[];l<h;++l)if((n=t[l])===t[l+1])++p;else if(p)u.push(d("th","highcharts-table-topheading",{scope:"col",colspan:p+1},n)),p=0;else{n===e[l]?o.exporting.useRowspanHeaders?(r=2,delete e[l]):(r=1,e[l]=""):r=1;var f=d("th","highcharts-table-topheading",{scope:"col"},n);r>1&&f.attributes&&(f.attributes.valign="top",f.attributes.rowspan=r),u.push(f)}s.push({tagName:"tr",children:u})}if(e){var u=[];for(l=0,h=e.length;l<h;++l)void 0!==e[l]&&u.push(d("th",null,{scope:"col"},e[l]));s.push({tagName:"tr",children:u})}return{tagName:"thead",children:s}}(s,l,Math.max(e,l.length)));var u=[];r.forEach(function(t){for(var a=[],o=0;o<e;o++)a.push(d(o?"td":"th",null,o?{}:{scope:"row"},t[o]));u.push({tagName:"tr",children:a})}),a.push({tagName:"tbody",children:u});var m={tree:{tagName:"table",id:"highcharts-data-table-".concat(this.index),children:a}};return g(this,"aftergetTableAST",m),m.tree}function S(){this.toggleDataTable(!1)}function C(e){var a=(e=v(e,!this.isDataTableVisible))&&!this.dataTableDiv;if(a&&(this.dataTableDiv=d.createElement("div"),this.dataTableDiv.className="highcharts-data-table",this.renderTo.parentNode.insertBefore(this.dataTableDiv,this.renderTo.nextSibling)),this.dataTableDiv){var o=this.dataTableDiv.style,n=o.display;o.display=e?"block":"none",e?(this.dataTableDiv.innerHTML=t.emptyHTML,new t([this.getTableAST()]).addToDOM(this.dataTableDiv),g(this,"afterViewData",{element:this.dataTableDiv,wasHidden:a||n!==o.display})):g(this,"afterHideData")}this.isDataTableVisible=e;var i=this.exportDivElements,r=this.options.exporting,s=r&&r.buttons&&r.buttons.contextButton.menuItems,l=this.options.lang;if(r&&r.menuItemDefinitions&&l&&l.viewData&&l.hideData&&s&&i){var c=i[s.indexOf("viewData")];c&&t.setElementHTML(c,this.isDataTableVisible?l.hideData:l.viewData)}}function A(){this.toggleDataTable(!0)}function R(t,e){var a=h.navigator,o=h.URL||h.webkitURL||h;try{if(a.msSaveOrOpenBlob&&h.MSBlobBuilder){var n=new h.MSBlobBuilder;return n.append(t),n.getBlob("image/svg+xml")}return o.createObjectURL(new h.Blob(["\uFEFF"+t],{type:e}))}catch(t){}}function k(){var t=this,e=t.dataTableDiv,a=function(t,e){return t.children[e].textContent};if(e&&t.options.exporting&&t.options.exporting.allowTableSorting){var o=e.querySelector("thead tr");o&&o.childNodes.forEach(function(o){var n=o.closest("table");o.addEventListener("click",function(){var i,s,l=r([],e.querySelectorAll("tr:not(thead tr)"),!0),c=r([],o.parentNode.children,!0);l.sort((i=c.indexOf(o),s=t.ascendingOrderInTable=!t.ascendingOrderInTable,function(t,e){var o,n;return o=a(s?t:e,i),n=a(s?e:t,i),""===o||""===n||isNaN(o)||isNaN(n)?o.toString().localeCompare(n):o-n})).forEach(function(t){n.appendChild(t)}),c.forEach(function(t){["highcharts-sort-ascending","highcharts-sort-descending"].forEach(function(e){t.classList.contains(e)&&t.classList.remove(e)})}),o.classList.add(t.ascendingOrderInTable?"highcharts-sort-ascending":"highcharts-sort-descending")})})}}function O(){this.options&&this.options.exporting&&this.options.exporting.showTable&&!this.options.chart.forExport&&this.viewData()}function U(){var t;null===(t=this.dataTableDiv)||void 0===t||t.remove()}return{compose:function(t,e){var a=t.prototype;if(!a.getCSV){var n=s().exporting;p(t,"afterViewData",k),p(t,"render",O),p(t,"destroy",U),a.downloadCSV=y,a.downloadXLS=w,a.getCSV=D,a.getDataRows=T,a.getTable=E,a.getTableAST=L,a.hideData=S,a.toggleDataTable=C,a.viewData=A,n&&(f(n.menuItemDefinitions,{downloadCSV:{textKey:"downloadCSV",onclick:function(){this.downloadCSV()}},downloadXLS:{textKey:"downloadXLS",onclick:function(){this.downloadXLS()}},viewData:{textKey:"viewData",onclick:function(){b.call(this,this.toggleDataTable)}}}),n.buttons&&n.buttons.contextButton.menuItems&&n.buttons.contextButton.menuItems.push("separator","downloadCSV","downloadXLS","viewData")),l(o);var i=e.types,r=i.arearange,c=i.gantt,d=i.map,h=i.mapbubble,u=i.treemap,m=i.xrange;r&&(r.prototype.keyToAxis={low:"y",high:"y"}),c&&(c.prototype.exportKey="name",c.prototype.keyToAxis={start:"x",end:"x"}),d&&(d.prototype.exportKey="name"),h&&(h.prototype.exportKey="name"),u&&(u.prototype.exportKey="name"),m&&(m.prototype.keyToAxis={x2:"x"})}}}}),a(e,"masters/modules/export-data.src.js",[e["Core/Globals.js"],e["Extensions/DownloadURL.js"],e["Extensions/ExportData/ExportData.js"]],function(t,e,a){return t.dataURLtoBlob=t.dataURLtoBlob||e.dataURLtoBlob,t.downloadURL=t.downloadURL||e.downloadURL,a.compose(t.Chart,t.Series),t})});