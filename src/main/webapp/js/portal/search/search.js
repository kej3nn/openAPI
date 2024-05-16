var isSearchMobile = "N";

$(document).ready(function() {
	
	$('#n_query').keyup(function(event) {
		if(event.keyCode == 13 && $('#n_query').val !='') {
			doDetail();
		}
	});
	var mFilter = "win16|win32|win64|mac|macintel";
	
	if(mFilter.indexOf(navigator.platform.toLowerCase())<0)
		isSearchMobile = "Y";
});
function detailSearchOnOFF(){
	  
	  var cV =  $("#detailsearch").attr('class') ;
	  if( cV.indexOf('on') <= -1){
		  $("#detailsearch").addClass("on");
		  $(".ysearch_detail").css('display','block');
		  if(( $("#dateRange").val() =="" || $("#dateRange").val() =="A") && $("#startDate").val()=='19300101'){
		  }
		  gfn_portalCalendar($("#stDt"));
		  gfn_portalCalendar($("#edDt"));
	  }else{
		  $("#detailsearch").removeClass("on");
		  $(".ysearch_detail").css('display','none');
	  }
  }

function detailReset(){
	$(":input:radio[name=date_range]:checked").val();
	$("#stDt").val('');
	$("#edDt").val('');
	$("#n_query").val('');
	$(":input:radio[name=s_field]").prop("checked", false);
	$(":input:radio[name=date_range]").prop("checked", false);
	$(":input:radio[name=s_field]:radio[value='ALL']").prop("checked", true);
	$(":input:radio[name=date_range]:radio[value='A']").prop("checked", true);
}

function getCloud(count) {
	
	$('#groupField').val('A');
	$.ajax({
	  	type: "POST",
	  	url: "/portal/search/getGroup.do",
	  	type:'POST',
	  	dataType: "json",
	  	data: jQuery("#search").serialize(),
	  	success: function(d) {
	  		dataList = [];
	        $.each(d.terms, function(i, d) {
	        //	console.log("terms rank ["+result.rank+"]");
	  		//	console.log("terms key ["+d.key+"]");
	  		//	console.log("terms value ["+result.value+"]");
	          if(i < count){
	        	//  console.log(i + "terms key ["+d.key+"]");
	            dataList.push({
		            text: d.key,
		            size: 25-i
	            });
	          }
	        });
	      },
	      complete : function(data) {
        	drawChart(dataList);
	      },
	      error : function(request, status, error) {
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	    })
}

function drawChart(data) {
	  var url = "";
	  var weight = 2, // 글자크기 가중치
	    width =  185,
	    height = 168;
	  
	  if(isSearchMobile == 'Y'){
		    var weight = 2,
			width = $('#searchcloud').width(),
			height = $('#searchcloud').height();
		}else{
			var weight = 2, // 글자크기 가중치
		    width =  185,
		    height = 168;
		}

	  var fill = d3.scale.category20();

  d3.layout.cloud().size([width, height]).words(data)
    //.rotate(function() { return ~~(Math.random() * 2) * 90; })
    .rotate(0)
    .font("Impact")
    .fontSize(function (d) {
      return d.size;
    })
    .on("end", draw)
    .start();

  function draw(words) {
    d3.select("#searchcloud").append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
      .selectAll("text")
      .data(words)
      .enter().append("text")
      .style("font-size", function (d) {
        return d.size + "px";
					})
					.style("font-family", "Impact")
      .style("fill", function (d, i) {
        return fill(i);
      })
      .attr("text-anchor", "middle")
      .attr("transform", function (d) {
        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
				})
				.style("cursor", "pointer")
				.attr("onclick", function (d) {
        return "doKeyword('" + d.text + "')";
      })
      .text(function (d) {
        return d.text;
      });
  }
};


 function getPopkeyword(range, collection) {
	
	 $.ajax({
		  	type: "POST",
		  	url: "/portal/search/getPopword.do",
		  	dataType: "json",
		  	data: { "range" : range, "collection" : collection , "target" : "popword" },
		  	success: function(datahtml) {
		  		var str = "";
		  		//console.log("getPopkeyword["+datahtml+"]");
		  		if(datahtml == null){
		  			str = "";
		  		}else{
		  		var dataJson = JSON.parse(datahtml); 
		  		
			  		$.each(dataJson.Data.Query, function(i, result) {
			  			
			  			if(i < 10){
				  			str = str + "<li>";
							
					  		str = str + "<a href=\"javascript:doKeyword('" + result.content + "');\" class=\"rank"+ result.id +"\" >"+result.content+"</a>";
							/*if (result.updown == "U") {
					  			
					  			str = str + "<span class=\"xi-caret-up up\">상승</span>"+result.count;
					  			//str = str + "<img src='images/ico_up.gif' alt='상승' />";
							} else if (result.updown == "D") {
								str = str + "<span class=\"xi-caret-down down\">하락</span>"+result.count;
								//str = str + "<img src='images/ico_down.gif' alt='하락' />";
							} else if (result.updown == "N") {
								str = str + "<span class=\"new\">new</span>";
								//str = str + "<img src='images/ico_new.gif' alt='신규' />";
							} else if (result.updown == "C") {
								str = str + "<span class=\"same\">동일</span>"+result.count;
								//str = str + "-";
							}*/
					  		str = str + "</li>";
			  			}
				  	});
		  		}
			  	
			  	$("#poplist").html(str);
		  }
		});
	}
 
 function getGroup(query) {
	var links= [];
	var node= [];
	var data= [];
	 $.ajax({
		  	type: "POST",
		  	url: "/portal/search/getGroup.do",
		  	type:'POST',
		  	dataType: "json",
		  	data: jQuery("#search").serialize(),
		  	success: function(d) {
		  		//var dataJson = JSON.parse(d); 
		  		//console.log("getGroup ["+d+"]");
		  		//alert(dataJson.terms.size());
		  		 $.each(d.terms, function(i, d) {
				        //	console.log("terms rank ["+d.rank+"]");
				  		//	console.log("terms key ["+d.key+"] : " + i );
				            });
			 }, complete : function(d){
		  
		  }
		});
}
 
 function getNetwork(query){
	 $('#groupField').val('A');
	 var links = [];
	  var nodes = {};
	  $.ajax({
		  	type: "POST",
		  	url: "/portal/search/getGroup.do",
		  	type:'POST',
		  	dataType: "json",
		  	data: jQuery("#search").serialize(),
		  	success: function(d) {
		        $.each(d.terms, function(i, d) {
		        //	console.log("terms rank ["+result.rank+"]");
		  		//	console.log("terms key ["+d.key+"] : " + i );
		        	if( 3 < i && i < 9){
		        	  links.push({
		        		  source: d.key,
				          target: query
				         // type: "resolved"
		            });
		          }
		        });
		      },
		      complete : function() {
				// Compute the distinct nodes from the links.
				links.forEach(function(link) {
					  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
					  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
					  link.value =+ link.value;
				});
				
				
				
				
				if(isSearchMobile == 'Y'){
					var width = $('#network').width() ,
					height = $('#network').height();
				}else{
					var width = 185,
				    height = 165;
				}
				var force = d3.layout.force()
				.nodes(d3.values(nodes))
				.links(links)
				.size([width, height])
				.linkDistance(50)
				.charge(-200)
				.on("tick", tick)
				.start();
				
		
				var svg = d3.select("#network").append("svg")
				.attr("width", width)
				.attr("height", height)
				;
		
				var link = svg.selectAll(".link")
				.data(force.links())
				.enter().append("line")
				.attr("class", "link");
		
				var node = svg.selectAll(".node")
				.data(force.nodes())
				.enter().append("g")
				.attr("class", "node")
				.on("mouseover", mouseover)
				.on("mouseout", mouseout)
				//.on("click", click)
				//.on("dblclick", dblclick)
				.attr("onclick", function (d) {
				        return "doKeyword('" + d.name + "')";
				      })
				.call(force.drag);
		
				node.append("circle")
				.attr("r", 8)
				.style("fill", "#3182bd");
		
				node.append("text")
				.attr("x", 12)
				.attr("dy", ".35em")
				.style("fill", "#000")
				.text(function(d) { return d.name; });
		
				function tick() {
				link
				.attr("x1", function(d) { return d.source.x; })
				.attr("y1", function(d) { return d.source.y; })
				.attr("x2", function(d) { return d.target.x; })
				.attr("y2", function(d) { return d.target.y; });
		
				node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
				}
		
				function mouseover() {
				d3.select(this).select("circle").transition()
				.duration(750)
				.attr("r", 16);
				}
		
				function mouseout() {
				d3.select(this).select("circle").transition()
				.duration(750)
				.attr("r", 8);
				}
				// action to take on mouse click
				function click() {
				d3.select(this).select("text").transition()
				.duration(750)
				.attr("x", 22)
				.style("stroke-width", ".5px")
				.style("opacity", 1)
				.style("fill", "#E34A33")
				.style("font", "37.5px serif");
				d3.select(this).select("circle").transition()
				.duration(750)
				.style("fill", "#E34A33")
				.attr("r", 16)
				}
		
				// action to take on mouse double click
				function dblclick() {
				d3.select(this).select("circle").transition()
				.duration(750)
				.attr("r", 6)
				.style("fill", "#E34A33");
				d3.select(this).select("text").transition()
				.duration(750)
				.attr("x", 12)
				.style("stroke", "none")
				.style("fill", "#E34A33")
				.style("stroke", "none")
				.style("opacity", 0.6)
				.style("font", "15px serif");
				}
		   }
 
	  })
 }

 function drawNetwork(query) {
	  var links = [];
	  var nodes = [];
	  $.ajax({
		  	type: "POST",
		  	url: "/portal/search/getGroup.do",
		  	type:'POST',
		  	dataType: "json",
		  	data: jQuery("#search").serialize(),
		  	success: function(d) {
		        $.each(d.terms, function(i, d) {
		        //	console.log("terms rank ["+result.rank+"]");
		  		//	console.log("terms key ["+d.key+"] : " + i );
		        	if( 5 < i && i < 11){
		        	  links.push({
		        		  source: d.key,
				          target: query,
				          type: "resolved"
		            });
		          }
		        });
		      },
		      complete : function() {
		// Compute the distinct nodes from the links.
		links.forEach(function(link) {
			  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
			  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
		});

		var width = 185,
		    height = 165;


		var force = d3.layout.force()
		    .nodes(d3.values(nodes))
		    .links(links)
		    .size([width, height])
		    .linkDistance(50)
		    .charge(-400)
		    .on("tick", tick)
		    .start();

		var svg = d3.select("#network").append("svg")
		    .attr("width", width)
		    .attr("height", height);

		var path = svg.append("g").selectAll("path")
		    .data(force.links())
		  .enter().append("path")
		    .attr("class", "link")
		    .style("fill","none")
		    .style("stroke","#ccc")
		    .style("stroke-width","3px");
		
		var circle = svg.append("g").selectAll("circle")
		    .data(force.nodes())
		  .enter().append("circle")
		    .attr("r", 5)
		    .attr("cx",2)
		    .attr("cy",4)
		    .style("fill","none")
		    .style("stroke","#220")
		    .style("stroke-width","2px")
		    
		    .call(force.drag);

		var text = svg.append("g").selectAll("text")
		    .data(force.nodes())
		  .enter().append("text")
		    .attr("x", 0)
		    .attr("y", -5)
		    .text(function(d) { return d.name; }
		    )
		    .attr("onclick", function (d) {
		        return "doKeyword('" + d.name + "')";
		      });


		// Use elliptical arc path segments to doubly-encode directionality.
		function tick() {
			path.attr("d", linkArc);
		  circle.attr("transform", transform);
		  text.attr("transform", transform);
		}

		function linkArc(d) {
		  var dx = d.target.x - d.source.x,
		      dy = d.target.y - d.source.y,
		      dr = Math.sqrt(dx * dx + dy * dy);
		  return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
		}

		function transform(d) {
		  return "translate(" + d.x + "," + d.y + ")";
		}
	}
});
		
}
 
 
 
 
//인기검색어, 내가찾은 검색어
  function doKeyword(query) {
  	var searchForm = document.search; 
  	searchForm.startCount.value = 1;
  	searchForm.query.value = query;
  	//searchForm.collection.value = "ALL";
  	//searchForm.viewCount = "3";
  	searchForm.sort.value = "RANK";
  	searchForm.query.value = query;
  	doSearch();
  }

  // 쿠키값 조회
  function getCookie1(c_name) {
  	var i,x,y,cookies=document.cookie.split(";");
  	for (i=0;i<cookies.length;i++) {
  		x=cookies[i].substr(0,cookies[i].indexOf("="));
  		y=cookies[i].substr(cookies[i].indexOf("=")+1);
  		x=x.replace(/^\s+|\s+$/g,"");
  	
  		if (x==c_name) {
  			return unescape(y);
  		}
  	}
  }

  // 쿠키값 설정
  function setCookie1(c_name,value,exdays) {
  	var exdate=new Date();
  	exdate.setDate(exdate.getDate() + exdays);
  	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  	document.cookie=c_name + "=" + c_value;
  }

  // 내가 찾은 검색어 조회
  function getMyKeyword(keyword, totCount) {
  	var MYKEYWORD_COUNT = 6; //내가 찾은 검색어 갯수 + 1
  	var myKeyword = getCookie1("mykeyword");
  	if( myKeyword== null) {
  		myKeyword = "";
  	}

  	var myKeywords = myKeyword.split("^%");

  	if( totCount > 0 ) {
  		var existsKeyword = false;
  		for( var i = 0; i < myKeywords.length; i++) {
  			if( myKeywords[i] == keyword) {
  				existsKeyword = true;
  				break;
  			}
  		}

  		if( !existsKeyword ) {
  			myKeywords.push(keyword);
  			if( myKeywords.length == MYKEYWORD_COUNT) {
  				myKeywords = myKeywords.slice(1,MYKEYWORD_COUNT);
  			}
  		}
  		setCookie1("mykeyword", myKeywords.join("^%"), 365);
  	}

  	showMyKeyword(myKeywords.reverse());
  }


  // 내가 찾은 검색어 삭제
  function removeMyKeyword(keyword) {
  	var myKeyword = getCookie("mykeyword");
  	if( myKeyword == null) {
  		myKeyword = "";
  	}

  	var myKeywords = myKeyword.split("^%");

  	var i = 0;
  	while (i < myKeywords.length) {
  		if (myKeywords[i] == keyword) {
  			myKeywords.splice(i, 1);
  		} else { 
  			i++; 
  		}
  	}

  	setCookie1("mykeyword", myKeywords.join("^%"), 365);

  	showMyKeyword(myKeywords);
  }
   
  // 내가 찾은 검색어 
  function showMyKeyword(myKeywords) {
  	var str = "";

  	for( var i = 0; i < myKeywords.length; i++) {
  		if( myKeywords[i] == "") continue;

  		str += "<li><a href=\"#none\" onClick=\"javascript:doKeyword('"+myKeywords[i]+"');\">"+myKeywords[i]+"</a> <a href='#none' onClick=\"removeMyKeyword('"+myKeywords[i]+"');\" class='close'></a></li>";
  	}

  	$("#mykeyword").html(str);
  }

  // 오타 조회
  function getSpell(query) { 
  	$.ajax({
  	  type: "POST",
  	  url: "./popword/popword.jsp?target=spell&charset=",
  	  dataType: "xml",
  	  data: {"query" : query},
  	  success: function(xml) {
  		if(parseInt($(xml).find("Return").text()) > 0) {
  			var str = "<div class=\"resultall\">";

  			$(xml).find("Data").each(function(){			
  				if ($(xml).find("Word").text() != "0" && $(xml).find("Word").text() != query) {
  					str += "<span>이것을 찾으셨나요? </span><a href=\"#none\" onClick=\"javascript:doKeyword('"+$(xml).find("Word").text()+"');\">" + $(xml).find("Word").text() + "</a>";
  				}			
  			});
  			
  			str += "</div>";

  			$("#spell").html(str);
  		}
  	  }
  	});

  	return true;
  }

  // 기간 설정
  function setDate(range) {
  	var startDate = "";
  	var endDate = "";
  	
  	var currentDate = new Date();
  	var year = currentDate.getFullYear();
  	var month = currentDate.getMonth() +1;
  	var day = currentDate.getDate();
  	
  	if (parseInt(month) < 10) {
  		month = "0" + month;
  	}

  	if (parseInt(day) < 10) {
  		day = "0" + day;
  	}

  	var toDate = year + "-" + month + "-" + day;
  	
  	var startDate = new Date();
  	// 기간 버튼 이미지 선택
  	if (range == "w") {
  		startDate.setDate(startDate.getDate() -7) ;
  	} else if (range == "1m") {
  		startDate.setMonth(startDate.getMonth() -1) ;
  	} else if (range == "6m") {
  		startDate.setMonth(startDate.getMonth() -6) ;
  	} else if (range == "1y") {
  		startDate.setFullYear(startDate.getFullYear() -1) ;
  	}
  
  	
  	if (range != "A" && startDate != "") { 
  		year = startDate.getFullYear();
  		month = startDate.getMonth()+1; 
  		day = startDate.getDate();

  		if (parseInt(month) < 10) {
  			month = "0" + month;
  		}

  		if (parseInt(day) < 10) {
  			day = "0" + day;
  		}

  		startDate = year + "-" + month + "-" + day;				
  		endDate = toDate;
  	}else{
  		startDate = "";
  		endDate = "";
  	}
  	$("#stDt").val(startDate);
  	$("#edDt").val(endDate);
  }

  // 날짜 계산
  function getAddDay ( targetDate, dayPrefix )
  {
  	var newDate = new Date( );
  	var processTime = targetDate.getTime ( ) + ( parseInt ( dayPrefix ) * 24 * 60 * 60 * 1000 );
  	newDate.setTime ( processTime );
  	return newDate;
  }

  // 정렬
  function doSorting(sort) {
  	var searchForm = document.search;
  	searchForm.sort.value = sort;
  	searchForm.startCount.value = 1;
  	searchForm.reQuery.value = "2";
  	searchForm.action = "/portal/search/searchPage.do"
  	searchForm.submit();
  }

  // 검색
  function doSearch() {
  	var searchForm = document.search; 

  	if (searchForm.query.value == "") {
  		alert("검색어를 입력하세요.");
  		searchForm.query.focus();
  		return;
  	}
  	
  	//searchForm.collection.value = "ALL";
  	//searchForm.colTab.value = "";
  	searchForm.startDate.value = "";
  	searchForm.endDate.value = "";
  	searchForm.dateRange.value = "A";
  	searchForm.startCount.value = 1;
  	searchForm.reQuery.value = "";
  	searchForm.searchField.value = "ALL";
  	searchForm.detailYn.value = "N";
  	coll = searchForm.collection.value;
  	
  	if(coll.indexOf("iopen") >-1){
  		coll = "ALL";
  	}
  	
  	if(coll== "assem_act" || coll== "chairman" ||coll== "notice"  ||coll== "cmmnt"){
  		coll = "ALLA";
  	}
  	
  	if(coll.indexOf("ALL") >-1){
  		searchForm.viewCount.value = 3;
  	}
  	 
  	searchForm.collection.value = coll;
  	
  	if (document.getElementById("reChk").checked == true) {
  		searchForm.reQuery.value = "1";
  	}
  	searchForm.sort.value = "RANK";
  	searchForm.action = "/portal/search/searchPage.do";
  	searchForm.submit();
  }
  
  function doTagSearch(tag){
	  var searchForm = document.search; 
	  searchForm.query.value = tag;
	  searchForm.startCount.value = 1;
	  searchForm.action = "/portal/search/searchPage.do";
	  searchForm.submit();
	  
  }
  
  function doDetail(){
	  var searchForm = document.search; 
	  if($("#stDt").val() != "" || $("#edDt").val() != "") {
	  		if($("#stDt").val() == "") {
	  			alert("시작일을 입력하세요.");
	  			$("#stDt").focus();
	  			return;
	  		}

	  		if($("#edDt").val() == "") {
	  			alert("종료일을 입력하세요.");
	  			$("#edDt").focus();
	  			return;
	  		}

	  		if(!compareStringNum($("#stDt").val(), $("#edDt").val(), "-")) {
	  			alert("기간이 올바르지 않습니다. 시작일이 종료일보다 작거나 같도록 하세요.");
	  			$("#stDt").focus();
	  			return;
	  		}		
	  	}
	  searchForm.startCount.value = 1;
	  searchForm.detailYn.value = 'Y';
	  searchForm.startDate.value = $("#stDt").val();
	  searchForm.endDate.value = $("#edDt").val();
	  searchForm.dateRange.value = $(":input:radio[name=date_range]:checked").val();
	  searchForm.searchField.value = $(":input:radio[name=s_field]:checked").val();
	  
	  if($('#n_query').val()!=''){
		  $('#query').val( $('#query').val() + " !"+ $('#n_query').val())
	  }
	  
	  searchForm.action = "/portal/search/searchPage.do"
	  searchForm.submit();
  }
  
  // 컬렉션별 검색
  function doCollection(coll, tab) {
  	var searchForm = document.search; 
  	searchForm.collection.value = coll;
  	searchForm.colTab.value = tab;
  	searchForm.reQuery.value = "2";
  	searchForm.startCount.value = 1;
  	if(coll.indexOf("ALL") >-1){
  		searchForm.viewCount.value = 3;
  	}
  	searchForm.action = "/portal/search/searchPage.do"
  	searchForm.submit();
  }
  
  function doCollectionM(){
	  var searchForm = document.search; 
	  var coll = $('#colselect option:selected').val();
	  	searchForm.collection.value = coll
	  	searchForm.colTab.value = $('#colselect option:selected').attr('class');
	  	searchForm.reQuery.value = "2";
	  	searchForm.startCount.value = 1;
	  	if(coll.indexOf("ALL") >-1){
	  		searchForm.viewCount.value = 3;
	  	}
	  	
	  	searchForm.action = "/portal/search/searchPage.do"
	  	searchForm.submit();
  }
  	
  // 엔터 체크	
  function pressCheck() {   
  	if (event.keyCode == 13) {
  		return doSearch();
  	}else{
  		return false;
  	}
  }

  var temp_query = "";

  // 결과내 재검색
  function checkReSearch() {
  	var searchForm = document.search;
  	var query = searchForm.query;
  	var reQuery = searchForm.reQuery;

  	if (document.getElementById("reChk").checked == true) {
  		temp_query = query.value;
  		reQuery.value = "1";
  		query.value = "";
  		query.focus();
  	} else {
  		query.value = trim(temp_query);
  		reQuery.value = "";
  		temp_query = "";
  	}
  }

  // 페이징
  function doPaging() {
  	var searchForm = document.search;
  	//searchForm.startCount.value = count;
  	searchForm.reQuery.value = "2";
  	searchForm.action = "/portal/search/searchPage.do"
  	searchForm.submit();
  }

  // 기간 적용
  function doRange() {
  	var searchForm = document.search;
  	
  	if($("#startDate").val() != "" || $("#endDate").val() != "") {
  		if($("#startDate").val() == "") {
  			alert("시작일을 입력하세요.");
  			$("#startDate").focus();
  			return;
  		}

  		if($("#endDate").val() == "") {
  			alert("종료일을 입력하세요.");
  			$("#endDate").focus();
  			return;
  		}

  		if(!compareStringNum($("#startDate").val(), $("#endDate").val(), ".")) {
  			alert("기간이 올바르지 않습니다. 시작일이 종료일보다 작거나 같도록 하세요.");
  			$("#startDate").focus();
  			return;
  		}		
  	}

  	searchForm.startDate.value = $("#startDate").val();
  	searchForm.endDate.value = $("#endDate").val();
  	searchForm.reQuery.value = "2";
  	searchForm.action = "/portal/search/searchPage.do"
  	searchForm.submit();
  }

  // 영역
  function doSearchField(field) {
  	var searchForm = document.search;
  	searchForm.searchField.value = field;
  	searchForm.reQuery.value = "2";
  	searchForm.action = "/portal/search/searchPage.do"
  	searchForm.submit();
  }

  // 문자열 숫자 비교
  function compareStringNum(str1, str2, repStr) {
  	var num1 =  parseInt(removeReg(str1));
  	var num2 = parseInt(removeReg(str2));
  	
  	if (num1 > num2) {
  		return false;
  	} else {
  		return true;
  	}
  }
  
  function removeReg(str){
	  var regExp = /[\{\}\[\]\/?.,;:|\)*~!@#$%^&*\-<>\=\(\'\"]/gi;
	  if(regExp.test(str)){
		  str = str.replace(regExp,"");
	  }
	  return str;
	  
  }
  // Replace All
  function replaceAll(str, orgStr, repStr) {
  	return str.split(orgStr).join(repStr);
  }

  // 공백 제거
  function trim(str) {
  	return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
  }
  
  function viewSearchPaging(count, pages, page) {
		pages = pages || 1;
		page = page || 1;
		
		// 페이지 표시되는 영역
		var pager = $("#result-pager-sect");
		var pageCnt = 5; // 몇페이지씩
		
		if ( count > 0 ) {
			
			// 페이지 상태 표시
			$("#pageStatus").text(page + "/" + pages + " page");
			
			// 현재 페이지
			$("input[name=startCount]").val(page);	
		    
		    pager.empty();
		    
		    if(page==1){
		    	pager.append(
		    			"<p class=\"paging-navigation\">"                                                       +
		    	         //   "<a href=\"#\" class=\"btn btn_page_first\" title=\"처음페이지 이동\"><strong>처음페이지 이동</strong></a>"   +
		    	            " "                                                                           +
		    	         //   "<a href=\"#\" class=\"btn btn_page_pre\" title=\"이전 10페이지 이동\"><strong>이전 10페이지 이동</strong></a>"  +
		    	            " "                                                                           +
		    	            "<a href=\"#\" class=\"btn-next btn_page_next\" title=\"다음  "+ pageCnt + "페이지 이동\">다음  "+ pageCnt + "페이지 이동</a>" +
		    	            " "                                                                           +
		    	            "<a href=\"#\" class=\"btn-last btn_page_last\" title=\"마지막페이지 이동\">마지막페이지 이동</a>"  +
		    	        "</p>"                                                                        
		    	    );
		    }
		    else{
		    	pager.append(
		    	        "<p class=\"paging-navigation\">"                                                       +
		    	            "<a href=\"#\" class=\"btn-first btn_page_first\" title=\"처음페이지 이동\">처음페이지 이동</a>"   +
		    	            " "                                                                           +
		    	            "<a href=\"#\" class=\"btn-pre btn_page_pre\" title=\"이전 "+ pageCnt + "페이지 이동\">이전  "+ pageCnt + "페이지 이동</a>"  +
		    	            " "                                                                           +
		    	            "<a href=\"#\" class=\"btn-next btn_page_next\" title=\"다음  "+ pageCnt + "페이지 이동\">다음  "+ pageCnt + "페이지 이동</a>" +
		    	            " "                                                                           +
		    	            "<a href=\"#\" class=\"btn-last btn_page_last\" title=\"마지막페이지 이동\">마지막페이지 이동</a>"  +
		    	        "</p>"                                                                          
		    	      
		    	    );
		    }
		    
		    if (pages > 0 && page > 1) {
		        pager.find(".btn_page_first").addClass("first");
		    }
		    else {
		        pager.find(".btn_page_first").css("cursor", "default");
		    }
		    
		    if (pages > 0 && page > pageCnt) {
		        pager.find(".btn_page_pre").addClass("previous");
		    }
		    else {
		        pager.find(".btn_page_pre").css("cursor", "default");
		    }
		    
		    var first = Math.floor((page - 1) / pageCnt) * pageCnt + 1;
		    var last  = first;
		    
		    for (var i = 0, n = first; i < pageCnt; i++, n++) {
		        if (n == page) {
		            pager.find(".btn_page_next").before("<strong class=\"page-number\" style=\"cursor:default;\">" + n + "</strong>");
		        }
		        else {
		            pager.find(".btn_page_next").before("<a href=\"#\" class=\"number page-number\">" + n + "</a>");
		        }
		        
		        pager.find(".btn_page_next").before(" ");
		        
		        if (n >= pages) {
		            last = n;
		            break;
		        }
		    }
		    
		    if (pages > 0 && last < pages) {
		        pager.find(".btn_page_next").addClass("next");
		    }
		    else {
		        pager.find(".btn_page_next").css("cursor", "default");
		    }
		    
		    if (pages > 0 && page < pages) {
		        pager.find(".btn_page_last").addClass("last");
		    }
		    else {
		        pager.find(".btn_page_last").css("cursor", "default");
		    }
		    
		    pager.find(".presentPage strong").text(page);
		    pager.find(".presentPage span").text(pages ? pages : 1);
		    
		    if (pages > 0 && page > 1) {
		        pager.find(".btn_page_preStep").addClass("previousStep");
		    }
		    else {
		        pager.find(".btn_page_preStep").css("cursor", "default");
		    }
		    
		    if (pages > 0 && page < pages) {
		        pager.find(".btn_page_nextStep").addClass("nextStep");
		    }
		    else {
		        pager.find(".btn_page_nextStep").css("cursor", "default");
		    }
		    
		    // 맨앞 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_first").bind("click", function() {
		    	if ($(this).hasClass("first")) {
			    	$("input[name=startCount]").val(1);
			    	doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("first") && event.which == 13 ) {
		    		$("input[name=startCount]").val(1);
		    		doPaging();
		    	}
		    });
		    	    
		    
		    // 이전 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_pre").bind("click", function() {
		    	if ($(this).hasClass("previous")) {
			    	$("input[name=startCount]").val((parseInt(pager.find(".page-number:first").text(), 10) - 1).toString());
			    	doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("previous") && event.which == 13 ) {
			    	$("input[name=startCount]").val((parseInt(pager.find(".page-number:first").text(), 10) - 1).toString());
			    	doPaging();
		    	}
		    });
		    
		    
		    pager.find(".number").each(function(index, element) {
		        // 번호 링크에 클릭 이벤트를 바인딩한다.
		        $(this).bind("click", function() {
		        	$("input[name=startCount]").val($(this).text());
		        	doPaging();
		        }).bind("keydown", function(event) {
			    	if ( event.which == 13 ) {
			    		$("input[name=startCount]").val($(this).text());
			    		doPaging();
			    	}
			    });
		    });
		    
		    // 다음 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_next").bind("click", function() {
		    	if ($(this).hasClass("next")) {
			        $("input[name=startCount]").val((parseInt(pager.find(".page-number:last").text(), 10) + 1).toString());
			        doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("next") && event.which == 13 ) {
		    		$("input[name=startCount]").val((parseInt(pager.find(".page-number:last").text(), 10) + 1).toString());
		    		doPaging();
		    	}
		    });
		    
		    // 맨뒤 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_last").bind("click", function() {
		    	if ($(this).hasClass("last")) {
		    		$("input[name=startCount]").val(pages.toString());
		    		doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("last") && event.which == 13 ) {
		    		$("input[name=startCount]").val(pages.toString());
		    		doPaging();
		    	}
		    });
		    
		    // 이전 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_preStep").bind("click", function() {
		    	if ($(this).hasClass("previousStep")) {
		    		$("input[name=startCount]").val((parseInt(pager.find(".presentPage strong").text(), 10) - 1).toString());
		    		doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("previousStep") && event.which == 13 ) {
		    		$("input[name=startCount]").val((parseInt(pager.find(".presentPage strong").text(), 10) - 1).toString());
		    		doPaging();
		    	}
		    });
		    
		    // 다음 버튼에 클릭 이벤트를 바인딩한다.
		    pager.find(".btn_page_nextStep").bind("click", function() {
		    	if ($(this).hasClass("nextStep")) {
		    		$("input[name=startCount]").val((parseInt(pager.find(".presentPage strong").text(), 10) + 1).toString());
		    		doPaging();
		    	}
		    }).bind("keydown", function(event) {
		    	if ( $(this).hasClass("nextStep") && event.which == 13 ) {
		    		$("input[name=startCount]").val((parseInt(pager.find(".presentPage strong").text(), 10) + 1).toString());
		    		doPaging();
		    	}
		    });
		    
		}
	}
  
  
  function previewFile1(path, ext , fname ){
	  
	  var preUrl = 'http://10.201.101.47:8099/uFOCS3.0/viewer/document/docviewer.do?userid=iopen&viewerselect=image';
	  
	  filepath = "&filepath=" + encodeURIComponent(path);
	  
	 
	  filename = "&filename=" + encodeURIComponent(fname);
	  if(ext =='nm'){
		  flen = fname.length;
		  lastdot = fname.lastIndexOf('.') +1;
		  ext = fname.substring(lastdot, flen);
		  
		  fileext  = "&fileext=" + encodeURIComponent(ext);
	  }else if(ext =='path'){
		  flen = path.length;
		  lastdot = path.lastIndexOf('.') +1;
		  ext = path.substring(lastdot, flen);
		  fileext  = "&fileext=" + encodeURIComponent(ext);
	  }else{
		  
		  fileext  = "&fileext=" + encodeURIComponent(ext);
	  }
		  
	  
	  preUrl = preUrl + filepath + filename + fileext;
	  window.open(preUrl);
	  
	  
  }
  
function previewFile(path, ext , fname ){
	  
	  //var preUrl = 'http://211.46.92.51:81/mview_scroll.php?FTYPE=jpeg&FLIVESERVER=http://211.46.92.51:47156';
	  var preUrl = 'http://media1.assembly.go.kr:81/mview_scroll.php?FTYPE=jpeg&FLIVESERVER=http://media1.assembly.go.kr:47158';
	  furl = 'http://media1.assembly.go.kr:47158?page=[PAGE]&size=12801024&type=jpg&webid=iopen&signcode=&LtpaToken=';
	  filepath = "&url=" + encodeURIComponent(path);
	  
	  furl = furl + filepath
	 
	  filename = "&FFILENAME=" + encodeURIComponent(fname);
	  
	  if(ext =='nm'){
		  flen = fname.length;
		  lastdot = fname.lastIndexOf('.') +1;
		  ext = fname.substring(lastdot, flen);
		  
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }else if(ext =='path'){
		  flen = path.length;
		  lastdot = path.lastIndexOf('.') +1;
		  ext = path.substring(lastdot, flen);
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }else{
		  
		  fileext  = "&ext=" + encodeURIComponent(ext);
	  }
		  
	  furl = furl + fileext
	  
	  furl = encodeURIComponent(furl)
	  preUrl = preUrl + "&FURL="+ furl + "&FEXT=" + ext + filename ;
	  window.open(preUrl);
	  
  }
  
