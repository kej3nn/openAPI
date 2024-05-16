
$(function(){
	$('.dataInfoVisual .selectbox select').on('change', function(){
		var txt = $(this).find('option:selected').text();
		$(this).prev('a').html(txt);
	});


	//visualArea_1
	setTimeout(counter, 0, true,'.counter1');
	setTimeout(counter, 1500, true,'.counter2');
	setTimeout(counter, 3500, true,'.counter3');
	setTimeout(counter, 5000, true,'.counter4');

	function counter(ani, arg){
		$(arg).html('');
		$(arg).rollingCounter({
			animate : ani,
			attrCount : 'data-count',
			easing : 'easeOutBounce',
		});
	}


	var dataMap={
		"map_1":"포천시",
		"map_2":"시흥시",
		"map_3":"가평군",
		"map_4":"김포시",
		"map_5":"여주군",
		"map_6":"화성시",
		"map_7":"안성시",
		"map_8":"연천군",
		"map_9":"동두천시",
		"map_10":"의정부시",
		"map_11":"양주시",
		"map_12":"파주시",
		"map_13":"고양시",
		"map_14":"양평군",
		"map_15":"이천시",
		"map_16":"구리시",
		"map_17":"남양주시",
		"map_18":"하남시",
		"map_19":"용인시",
		"map_20":"광주시",
		"map_21":"성남시",
		"map_22":"오산시",
		"map_23":"평택시",
		"map_24":"과천시",
		"map_25":"수원시",
		"map_26":"부천시",
		"map_27":"안산시",
		"map_28":"안양시",
		"map_29":"의왕시",
		"map_30":"군포시",
		"map_31":"광명시",
	}
	var dataColor={
		"color1":"#9a9a9a",
		"color2":"#9d9d9d",
		"color3":"#9fa0a0",
		"color4":"#a2a2a3",
		"color5":"#a5a5a6",
		"color6":"#a6a8a8",
		"color7":"#aaabac",
		"color8":"#acaeae",
		"color9":"#afb1b2",
		"color10":"#b1b3b4",
		"color11":"#b4b6b7",
		"color12":"#b7b9ba",
		"color13":"#b9bbbc",
		"color14":"#bcbebf",
		"color15":"#bec1c2",
		"color16":"#c1c4c5",
		"color17":"#c4c7c8",
		"color18":"#c6cacb",
		"color19":"#c9cdce",
		"color20":"#cccfd1",
		"color21":"#ced2d3",
		"color22":"#d1d5d6",
		"color23":"#d3d7d9",
		"color24":"#d6dadc",
		"color25":"#d8dddf",
		"color26":"#dbe0e1",
		"color27":"#dee3e5",
		"color28":"#e0e5e7",
		"color29":"#e3e8ea",
		"color30":"#e5ebed",
		"color31":"#e8eef0",
	}

	var dataColor3={
		"color1":"#34679a",
		"color2":"#3c6c9d",
		"color3":"#4271a0",
		"color4":"#4876a3",
		"color5":"#4d7aa6",
		"color6":"#537ea9",
		"color7":"#5a83ac",
		"color8":"#6088af",
		"color9":"#658cb1",
		"color10":"#6b90b4",
		"color11":"#7195b7",
		"color12":"#7799ba",
		"color13":"#7d9dbd",
		"color14":"#82a2bf",
		"color15":"#88a6c2",
		"color16":"#8fabc6",
		"color17":"#95b0c9",
		"color18":"#9ab3cb",
		"color19":"#9fb8cd",
		"color20":"#a5bcd0",
		"color21":"#acc1d3",
		"color22":"#b1c5d6",
		"color23":"#b8cad9",
		"color24":"#bdcedc",
		"color25":"#c3d3df",
		"color26":"#c9d7e1",
		"color27":"#cfdbe4",
		"color28":"#d4dfe7",
		"color29":"#dae4ea",
		"color30":"#e0e9ed",
		"color31":"#e6edf0",
	}

	var dataColor4={
		"color1":"#86a4ab",
		"color2":"#8aa7ae",
		"color3":"#8da9af",
		"color4":"#8fabb2",
		"color5":"#92adb3",
		"color6":"#95afb6",
		"color7":"#99b1b7",
		"color8":"#9bb3ba",
		"color9":"#9eb6bc",
		"color10":"#a1b8be",
		"color11":"#a4bac0",
		"color12":"#a7bcc2",
		"color13":"#abbfc4",
		"color14":"#afc1c6",
		"color15":"#b1c3c8",
		"color16":"#b5c6cb",
		"color17":"#b8c9cd",
		"color18":"#bbcbcf",
		"color19":"#bfcdd1",
		"color20":"#c3d0d4",
		"color21":"#c5d2d6",
		"color22":"#c8d5d9",
		"color23":"#cdd9dd",
		"color24":"#cfdbdf",
		"color25":"#d2dee2",
		"color26":"#d6e0e4",
		"color27":"#dae3e7",
		"color28":"#dee7eb",
		"color29":"#e1eaed",
		"color30":"#e5edf0",
		"color31":"#e9f0f3",
	}

	function mapData1(mapId, dataMap, dataColor){
		var map =[];
		for (var key in dataMap){map.push(key)}
		var color = []; 
		for(key in dataColor) {
			if(dataColor.hasOwnProperty(key)) {
				color.push(dataColor[key]);
			}
		}

		for (var i = 0;i<=31;i++){
			$('#'+mapId+' #'+map[i]).attr('fill', color[i]);
		}
	}

	mapData1('map1', dataMap, dataColor); // map1 맵지도
	mapData1('map2', dataMap, dataColor); // map2 맵지도

	var dataMap3={
		"map_6":"화성시", "map_19":"용인시", "map_27":"안산시", 
		"map_12":"파주시", "map_23":"평택시", "map_25":"수원시", 
		"map_21":"성남시", "map_15":"이천시", "map_13":"고양시", 
		"map_26":"부천시", "map_2":"시흥시", "map_4":"김포시", 
		"map_17":"남양주시", "map_7":"안성시", "map_1":"포천시", 
		"map_28":"안양시", "map_20":"광주시", "map_11":"양주시", 
		"map_10":"의정부시", "map_30":"군포시", "map_5":"여주시", 
		"map_22":"오산시", "map_31":"광명시", "map_18":"하남시", 
		"map_14":"양평군", "map_16":"구리시", "map_29":"의왕시", 
		"map_9":"동두천시", "map_3":"가평군", "map_8":"연천군", 
		"map_24":"과천시",
	}
	mapData1('map3', dataMap3, dataColor4); // map3 맵지도
	mapData1('map4', dataMap, dataColor3); //  map4 맵지도


});

// chartImg
$(function(){
	chartImgInit();
});
$(window).scroll(function(){
	chartImgInit();
});
function chartImgInit(){
	if (!$('.chartImg').size()>0) return;
	$('.fixPos').remove();
	$('body').append('<span style="position:fixed;top:0;" class="fixPos"></span>')
	var fs = $('.fixPos').offset().top  + 469;
	var os = $('.chartImg').offset().top;
	if(fs > os && !$('.chartImg').hasClass('on')){
		$('.chartImg').addClass('on');
		chartImg();
	}
}
function chartImg(){
	var m2 = function(){$('.chartImg img').eq(1).animate({opacity:1, height:142}, 1000, m3);	}
	var m3 = function(){$('.chartImg img').eq(2).animate({opacity:1}, 1000, m4);	}
	var m4 = function(){$('.chartImg img').eq(3).animate({opacity:1}, 800);}
	$('.chartImg img').eq(0).animate({opacity:1}, 500, m2);
}


//라인차트
var dataX2 = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월",]
var dataY2 = ["6,000,000", "5,000,000", "4,000,000", "3,000,000", "2,000,000", "1,000,000", "0"]


$(function(){
	chartBase('lineChart1', dataX2, dataY2);
	lineChartInit();
});

$(window).scroll(function(){
	lineChartInit();
});

function lineChartInit(){
	if (!$('.lineChart').size()>0) return;
	$('.fixPos2').remove();
	$('body').append('<span style="position:fixed;top:0;" class="fixPos2"></span>')
	var fs = $('.fixPos2').offset().top  + 530;
	var os = $('.lineChart').offset().top;
	if(fs > os && !$('.lineChart').hasClass('on')){
		$('.lineChart').addClass('on');
		$('.lineChart .barwrap').html('');

		lineChart('lineChart1', line1, 0.00011, 'circle1', '-10px');
		lineChart('lineChart1', line2, 0.00011, 'circle2', '-10px');
		lineChart('lineChart1', line3, 0.00011, 'circle3', '-10px');
		lineChart('lineChart1', line4, 0.00011, 'circle4', '-10px');
		lineChart('lineChart1', line5, 0.00011, 'circle5', '-10px');
		lineChart('lineChart1', line6, 0.00011, 'circle6', '-10px');
		lineChart('lineChart1', line7, 0.00011, 'circle7', '-10px');

		lineChartShow();
	}
}

function lineChartShow(){
	$('.lineChart .chartView .viewer .barwrap .view').stop().hide()
	$('.lineChart .chartView .viewer .barwrap .view').css({opacity:1, top:0}, 0)
	$('.lineChart .chartView .viewer .barwrap .view').stop().show( "fold", {horizFirst: true}, 2000 );
}

var line1 = [75968, 71093, 64877, 63710, 58942, 56467, 55508, 59090, 63015, 68249, 73078]; /*가로등 */
var line2 = [164490, 147792, 139991, 122457, 90695, 97981, 112208 , 107056, 117757, 91373 ,107484]; /*교육용 */
var line3 = [243643, 235373, 193537, 173685, 159265, 164298, 155547, 191424, 191631, 153825, 232987]; /*농사용*/
var line4 = [4997456, 4654334, 4668978, 4687510, 4507132, 4605337, 4689496, 4914070,  4682064, 4543867, 4657232]; /*산업용*/
var line5 = [588190, 543993, 435108, 337184, 198694, 119631, 89943 , 85021 , 80637 , 116542, 237768]; /*심야*/
var line6 = [2491129, 2309560, 2031222, 1911663, 1765492, 1900483, 2114563, 2372868, 2126610, 1812091, 1867333]; /*일반용*/
var line7 = [1453919, 1418450, 1249696, 1301466, 1212826, 1243018, 1276864, 1532794, 1344119, 1205782, 1295810]; /*주택용*/

function lineChart(obj, level, a, type, pos){

	var viewer = $('#'+obj+' .chartView .viewer .barwrap');
	var zSize = 100/level.length;

	var chart = '';

	chart+='<div class="view '+type+'" style="left:'+pos+';">';
	for (i=0;i<level.length;i++){
		var left= ((100/level.length)*(i+1))-((100/level.length)/2);
		chart+='<div class="circle circle'+i+'" style="left:'+left+'%;bottom:'+(level[i]*a)/2 +'px">';
		chart+='	<div class="circlein"></div></div><div class="line line'+i+'">';
		chart+='</div>';
	}
	chart+='</div>';

	viewer.append(chart)

	var aaa = viewer.find('.'+type).find('.circle');
	lindDrow(aaa, viewer);


	$('#'+obj+' .view.'+type).delay(1000).animate({opacity:1, top:0}, function(){
		var btm = parseInt($(this).find('.label').css('bottom'))-30;
		$(this).find('.label').animate({bottom:btm, opacity:1}, 500);
	});

	function lindDrow(size, viewer){
		var x = [];
		var y = [];

		size.each(function(){
			x.push($(this).position().left);
			y.push($(this).position().top);
		});

		var dx = [];
		var dy = [];

		for (var a=0;a<x.length-1;a++){
			dx.push(x[a] - x[a+1]);
		}

		for (var b=0;b<y.length-1;b++){
			dy.push(y[b] - y[b+1]);
		}

		var rad = [];
		var degree = [];

		for (var d=0;d<dx.length;d++){
			rad.push(Math.atan2(dy[d], dx[d]));
		}

		for (var e in dy){
			degree.push((rad[e]*180)/Math.PI);
		}

		var xx = [];
		var yy = [];
		var linew = [];

		//사선길이, 빗변길이
		//두점의 좌표차(x1-x2)2 + (y1-y2)2 를 루트로 씌운다

		for (var f=0;f<dx.length;f++){
			xx.push(Math.pow(dx[f], 2));
			yy.push(Math.pow(dy[f], 2));
			linew.push(Math.sqrt(xx[f]+yy[f]));
		}



		var  linesize = viewer.find('.'+type).find('.line').size() -1;


		for (var g = 0; g<linesize+1 ;g++ ){
			var index =g;

			viewer.find('.'+type).find('.line' + index).css({ 'transform': 'rotate(' + degree[g] + 'deg)', top:x[g], left:y[g] , width:linew[g]});


			var circley = y[g];
			var circley2 = y[g+1]

			var circlex = x[g];

			var linex = viewer.find('.'+type).find('.line' + index).position().left;
			var liney = viewer.find('.'+type).find('.line' + index).position().top;

			var movex = linex- circley;
			var movey = liney- circlex;

			if(circley > circley2){
				viewer.find('.'+type).find('.line' + index).css({top: y[g] + movey-5});
			}else{
				viewer.find('.'+type).find('.line' + index).css({top: y[g] - movey-5});
			}

			viewer.find('.'+type).find('.line' + index).css({left:x[g]- movex-5});
		}
	}

}

// 삼각형 차트
var dataX =["고정형CCTV", "차량이동형CCTV", "수기단속", "민원신고" ]; 
var dataY = ["30,000", "25,000", "20,000", "15,000", "10,000", "5,000"]; 
var dataBar = [29957, 16547 , 15324 , 10337]; 
var dataPer = ['20.0%', '11.0%' , '10.2%', '6.9%']; 


function chartBaseInit(obj){
	$('#'+obj).removeClass('on');
	$('#'+obj+' .xAxis .unit').html('');
	$('#'+obj+' .yAxis .unit').html('');
	$('#'+obj+' .chartView .viewer .barwrap').html('');
	$('#'+obj+' .chartView .viewer .bg').html('');
}

function chartBase(obj, unitX, unitY, unitY2){

		//chartBaseInit(obj);

		var xAxis = $('#'+obj+' .xAxis .unit');
		var yAxis = $('#'+obj+' .yAxis .unit');
		var viewer = $('#'+obj+' .chartView .viewer .barwrap');
		var viewerh = $('#'+obj+' .chartView').height();

		var viewerbg = $('#'+obj+' .chartView .viewer .bg');
		var bar = $('#'+obj+' .chartView .bar .chartbar');

		var zSizse = 100/unitX.length;
		var hSize = 100/unitY.length;

		function MakeX(){
			for (i=0;i<unitX.length;i++){
				$('<span style="width:'+zSizse+'%">'+unitX[i]+'</span>').appendTo(xAxis);
			}
		}
		 MakeX();

		function MakeY(){
			$('#'+obj+' .yAxis').css('height', viewerh);
			for (i=0;i<unitY.length;i++){
				$('<span style="height:'+hSize+'%">'+unitY[i]+'</span>').appendTo(yAxis);
				if(i == 0){
					$('<div class="bar" style="height:'+hSize/2+'%"></div>').appendTo(viewerbg);
					$('#'+obj+' .yAxis .unit span').css('height', +hSize/2+'%');
				}else{
					var other = (hSize/2)/(unitY.length-1);
					$('<div class="bar" style="height:'+(hSize+other)+'%"></div>').appendTo(viewerbg);
					$('#'+obj+' .yAxis .unit span').css('height', +(hSize+other)+'%');
				}
			}
			var h = viewer.height()/unitY.length;
			//yAxis.find('span:first-child').css('margin-top', h/2)

			 if($('#'+obj+' .yAxis2').size()>0){
				$('#'+obj+' .yAxis2').css('height', viewerh);
				$('#'+obj+' .yAxis2 .unit span').css('height', +(hSize+other)+'%');
			 }
		}
		 MakeY();

		 $('#'+obj).animate({opacity:1}, 500);

}


function triChart(obj, level, a, type, pos, per){
	var viewer = $('#'+obj+' .chartView .viewer .barwrap');
	var zSize = 100/level.length;

	var chart = '';
	chart+='<div class="view '+type+'" style="left:'+pos+';">';
	for (i=0;i<level.length;i++){
		chart+='<div class="gage">';
		chart+='	<span class="gagebar" level="'+level[i]*a+'" ><span class="per">'+per[i]+'</span><img src="../../../img/ggportal/desktop/data/visual/datainfovisual/gageTri_'+i+'.png" style="height:100%;width:100%;" alt="" /></span><em style="bottom:'+(level[i]*a+70)+'px">'+String(level[i]).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+'</em>';
		chart+='</div>';
	}
	chart+='</div>';

	viewer.append(chart)
	

	$('#'+obj+' .gage').each(function(i){
		var level = $(this).find('.gagebar').attr('level');
		if(level > viewer.height()){level = viewer.height()-70}
		if(level <0){
			$(this).parent().find('em').css('bottom', parseInt(level))
		$(this).find('.gagebar').delay(700).animate({height:Math.abs(level), bottom:level}, 700, function(){
			$(this).parent().find('em').animate({bottom:parseInt(level)+40, opacity:1}, 500);
		});
		}else{
			$(this).find('.gagebar').delay(700).animate({height:level}, 700, function(){
				$(this).parent().find('em').animate({bottom:parseInt(level)+40, opacity:1}, 500, chartTit);
			});
		}
	});

	var chartTit = function(){
		$('.chartArea .chartTit').animate({opacity:1}, 1000)
	}
}


function triChartInit(){
	if (!$('#triChart').size()>0) return;
	$('.fixPos').remove();
	$('body').append('<span style="position:fixed;top:0;" class="fixPos"></span>')
	var fs = $('.fixPos').offset().top  + $('#triChart').height();
	var os = $('#triChart').offset().top;
	if(fs > os && !$('#triChart').hasClass('on')){
		$('#triChart').addClass('on');
		chartBase('triChart', dataX, dataY);
		triChart('triChart', dataBar, 0.0094, '', '', dataPer);
	}
}
$(function(){
	triChartInit();
});

$(window).scroll(function(){
	triChartInit();
});