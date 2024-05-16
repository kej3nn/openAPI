/*
* ibchart 관련 javascript 
*
*/

function initChart(obj) {

	//차트 메인 색상
//	var colors = new Array("#FF0000", "#de9e49", "#c2a986", "#5e9359", "#5798cd", "#94c65d", "#5e65d9", "#8e4d9d", "#59d4dd", "#698889", "#c6cfcf", "#d6d7cb", "#d2c4b2", "#eadecd", "#903237", "#a68432", "#80a6a8");
//	obj.SetColors(colors);
//	//테두리 색상
//	obj.SetBorderColor('#99BCE8');
//	//배경색상
//	obj.SetBackgroundColor("#FFFFFF"); //배경색상변경
//	//테두리 두께
//	obj.SetBorderWidth(1);
//	//테두리 부드럽게 
//	obj.SetBorderRadius(5);
//	//차트 배경색상
//	obj.SetPlotBackgroundColor("#FFFFFF");
//	//차트 테두리
//	obj.SetPlotBorderColor('#99BCE8');
//	//차트 테두리 두께
//	obj.SetPlotBorderWidth(1);

	obj.SetOptions({
    Chart : {
			Type:"column"
			,BorderColor:'#99BCE8'
			,BackgroundColor:"#FFFFFF"
			,BorderWidth:1
			,BorderRadius:5
			,PlotBackgroundColor:"#FFFFFF"
			,plotBorderColor:'#99BCE8'
			,plotBorderWidth:1
		}
    ,Colors : ["#de5c60", "#de9e49", "#c2a986", "#5e9359", "#5798cd", "#94c65d", "#5e65d9", "#8e4d9d", "#59d4dd", "#698889", "#c6cfcf", "#d6d7cb", "#d2c4b2", "#eadecd", "#903237", "#a68432", "#80a6a8" ]
  });
 



	


}

function initXStyleChart(obj, xlncd, ylncd,lxtitNm){
	//X축 스타일
//	var Xaxis = obj.GetXAxis(0);      
//	Xaxis.SetGridLineColor(xlncd);	//축선색상(그리드 선 색상)
//	Xaxis.SetLineColor(ylncd); 	//격자색상(눈금 색상)
//	Xaxis.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
//	Xaxis.SetAxisTitle(new AxisTitle().SetStyle(new Style().SetFontFamily("Dotum").SetColor("#15498B")));
//	Xaxis.SetAxisTitleText(lxtitNm);			// x축 이름은 또 어디서....?
	if(xlncd == null) xlncd = "Purple";
	if(ylncd == null) ylncd = "Purple";
	var json = {
		GridLineColor:xlncd
		,LineColor:ylncd
		,Labels:{
			Style:{
//     Color:"#8B0A50"
//     ,FontWeight:'bold'
//     ,FontSize:'15px'
		     FontFamily:"Dotum"
		   }//Style
		}//Labels
		,Title:{
			 Text:lxtitNm
		   ,Style:{
		     FontFamily:"Dotum"
		     ,Color:"#15498B"
		    }
			}
		};
	obj.SetXAxisOptions(json,1);
}          

function initYStyleChart(obj, xlnCd, ylnCd, lytitNm){
	// 왼쪽 Y축 스타일
//	var Yaxis = obj.GetYAxis(0);
//	Yaxis.SetGridLineColor(xlnCd);	//축선색상(그리드 선 색상)
//	Yaxis.SetLineColor(ylnCd); 	//격자색상(눈금 색상)
//	Yaxis.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
//	Yaxis.SetAxisTitle(new AxisTitle().SetStyle(new Style().SetFontFamily("Dotum").SetColor("#15498B")));
//	if(lytitNm != "" )Yaxis.SetAxisTitleText(lytitNm);
	if(xlnCd == null) xlnCd = "Purple";
	if(ylnCd == null) ylnCd = "Purple";
	obj.SetYAxisOptions([{			//y축 옵션
			Title:{				//y축 제목설정
				Enabled:(lytitNm!="")
				,Text:lytitNm
				,Style:{			//css 입력
					Color: '#15498B',
					FontFamily: 'Dotum'
				}
			}
			,gridLineColor: xlnCd			//그리드 색상
			,labels: {						//라벨 설정
				style:{
					fontFamily: "Dotum"
				}                          
				,formatter:function(){
					return commaNumNew(this.value);               
				}
			}
			,lineColor: ylnCd				//라인색상
		}],1); 
}                       

function initYStylechart2(obj, xlnCd, ylnCd, rytitNm){
	if(rytitNm=="") return;
	
	obj.SetYAxisOptions([{}	,{
			Title:{				//y축 제목설정
					Enabled:(rytitNm!="")
					,Text:rytitNm
					,Style:{			//css 입력
						Color: '#15498B',
						FontFamily: 'Dotum'
					}
				}
      ,opposite: true
      ,gridLineDashStyle: "dot"	
			,labels: {						//라벨 설정
				style:{
					fontFamily: "Dotum"
				}
			}
		}
	],1); 
	
	
//	// 오른쪽 Y축 스타일
//	if(rytitNm != ""){
//		var Yaxis1 = obj.GetYAxis(1);
//		Yaxis1.SetOpposite(true);
//		Yaxis1.SetGridLineDashStyle("dot");
//		Yaxis1.SetGridLineColor(xlnCd);	//그리드 선 색상(축선)
//		Yaxis1.SetLineColor(ylnCd);	//눈금색상(격자)
//		Yaxis1.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
//		Yaxis1.SetAxisTitle(new AxisTitle().SetStyle(new Style().SetFontFamily("Dotum").SetColor("#15498B")));
//		Yaxis1.SetAxisTitleText(rytitNm);
//	}
}
	
function initToolTipSet(obj){
	
	obj.SetToolTipOptions({
		Style: {
			FontFamily:"Dotum"
	 	}
  	,Formatter:ToolTipFormatter2
	}, 1);
	
//	//툴팁 스타일
//	var tooltip = new ToolTip();
//	tooltip.SetFormatter(ToolTipFormatter);
//	tooltip.SetStyle(new Style().SetFontFamily("Dotum"));
//	obj.SetToolTip(tooltip);
}

function initLegend(obj,seriesPosx,seriesPosy,seriesOrd,seriesFyn){
	
	obj.SetLegendOptions({
		style:{
				color: '#15498B'
				,FontFamily: 'Dotum'
			}
	 ,Layout:seriesOrd  // ( horizontal, vertical )
   ,Align:seriesPosx  // ( left, center, right )
   ,VerticalAlign:seriesPosy//( top, middle, bottom )
   ,Floating:("Y" == seriesFyn?true:false)
	},1);
	
	
//	//범례 스타일
//	var legend = new Legend();
//	legend.SetItemStyle(new Style().SetColor("#15498B").SetFontFamily("Dotum"));
//	legend.SetItemHiddenStyle(new Style().SetFontFamily("Dotum"));
//	legend.SetItemHoverStyle(new Style().SetColor("#15498B").SetFontFamily("Dotum"));
//	legend.SetAlign(seriesPosx);		//가로위치
//	legend.SetVerticalAlign(seriesPosy);	//세로위치
//	legend.SetLayout(seriesOrd);	//정렬
//	if("Y" == seriesFyn){
//		legend.SetFloating(true);	//플로팅여부               
//	}else{
//		legend.SetFloating(false);	//플로팅여부
//	}
//	obj.SetLegend(legend);
}

function initLable(obj){
	
	obj.SetLabelsOptions({
	  Style:{                 
	   FontFamily:"Dotum"
	   ,FontWeight:"bold"
	   ,Color:"#15498B"
	  }
	},1);
	
//	//Label 스타일
//	var style = new Style().SetColor("#15498B").SetFontFamily("Dotum").SetFontWeight("bold");
//	obj.SetLabelsStyle(style);
}

function ToolTipFormatter() { 
	return '<b>' + this.point.name + '</b><br/>' + this.series.name + ' : ' + this.y;
}


//타입이름....
function fnChartType(obj,Type)
{
	var rtnType = "";
	var stack = "";
	switch(Type){
		case "IBChartType.BAR":
				obj.SetBaseOptions({
					Type:"bar"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:""
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.BAR;
				break;
		case "IBChartType.BAR_Stacking_Normal":
				obj.SetBaseOptions({
					Type:"bar"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.BAR;
				break;
		case "IBChartType.BAR_Stacking":
				obj.SetBaseOptions({
					Type:"bar"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:"percent"
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.BAR;
				break;
			
		case "IBChartType.COLUMN":
				obj.SetBaseOptions({
						Type:"column"
				},1);
					
				obj.SetPlotOptions({
					Series:{
							Stacking:""
						}
					},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.COLUMN
				break;
		case "IBChartType.COLUMN_Stacking_Normal":
				obj.SetBaseOptions({
						Type:"column"
				},1);
					
				obj.SetPlotOptions({
					Series:{
							Stacking:"normal"
						}
					},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.COLUMN
				break;
		case "IBChartType.COLUMN_Stacking":
				obj.SetBaseOptions({
						Type:"column"
				},1);
					
				obj.SetPlotOptions({
					Series:{
							Stacking:"percent"
						}
					},1);
				YAxisDesignStacking(obj);
				rtnType = IBChartType.COLUMN
				break;
		
		case "IBChartType.LINE":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;
		case "IBChartType.LINE_Stacking_Normal":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;

		case "IBChartType.LINE_Stacking":
				obj.SetBaseOptions({
//					margin:[50,0,0,0],
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"percent"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignStacking(obj);
				rtnType = IBChartType.LINE;		
				break;	
					
		case "IBChartType.LINE_Marker":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;
		case "IBChartType.LINE_Stacking_Normal_Marker":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;
		case "IBChartType.LINE_Stacking_Marker":
				obj.SetBaseOptions({
//					margin:[50,0,0,0],
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:false
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;
		case "IBChartType.LINE_Step":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:true
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;
		case "IBChartType.LINE_Step_Marker":
				obj.SetBaseOptions({
					Type:"line"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					},
					Line:{
						Step:true
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.LINE;		
				break;

		case "IBChartType.SPLINE":
				obj.SetBaseOptions({
					Type:"spline"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.SPLINE;		
				break;
		case "IBChartType.SPLINE_Marker":
				obj.SetBaseOptions({
					Type:"spline"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.SPLINE;		
				break;
		case "IBChartType.SCATTER":
				obj.SetBaseOptions({
					Type:"scatter"
				},1);
				
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.SCATTER;
				break;
		
		case "IBChartType.AREA":
		
				obj.SetBaseOptions({
					Type:"area"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.AREA;
				break;
		case "IBChartType.AREA_Stacking_Normal":
		
				obj.SetBaseOptions({
					Type:"area"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:"normal"
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.AREA;
				break;
		case "IBChartType.AREA_Stacking":
				obj.SetBaseOptions({
					Type:"area"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:"percent"
						,Marker:{
							Enabled:true
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.AREA;
		
		case "IBChartType.AREA_SPLINE":
				obj.SetBaseOptions({
					Type:"areaspline"
				},1);
				obj.SetPlotOptions({
					Series:{
						Stacking:""
						,Marker:{
							Enabled:true                 
						}
					}
				},1);
				YAxisDesignDefault(obj);
				rtnType = IBChartType.AREA_SPLINE;
				break;

		case "IBChartType.PIE":
		case "IBChartType.PIE_Sliced":
					obj.SetBaseOptions({
						Type:"pie"
					},1);
					
					obj.SetPlotOptions({
						Series:{
							DataLabels:{
								Enabled:true,
								Style:{
									FontSize:12	
								}
							}
						},
						Pie:{
							InnerSize:0,
							SlicedOffset:20,
							AllowPointSelect:true,
							showInLegend: true
						}
					},1);
					YAxisDesignStacking(obj);
					rtnType = IBChartType.PIE;
					break;
		
		
		
		
		case "IBChartType.PIE_InnerSize":
		case "IBChartType.PIE_Sliced_InnerSize":
					obj.SetBaseOptions({
						Type:"pie"
					},1);
					
					obj.SetPlotOptions({
						Series:{
							DataLabels:{
								Enabled:true,
								Style:{
									FontSize:12	
								}
							}
						},
						Pie:{
							InnerSize:100,
							SlicedOffset:20,
							AllowPointSelect:true,
							showInLegend: true
						}
					},1);
					YAxisDesignStacking(obj);
					rtnType = IBChartType.PIE;
					break;
		
	}
	obj.Draw();
	return rtnType;
	
}


function fnChartAddSeries(obj, data,dataNm, valueNm,colNm){
	var type= fnChartType(obj,"IBChartType.COLUMN");
	var series = obj.CreateSeries();
	series.SetProperty({                                          
		 Type:type                      
	 });                      
	series.AddPoints(data);                                                                    
	series.SetName(colNm);	
	obj.AddSeries(series);
	obj.SetXAxisLabelsText(0, dataNm);               
	obj.Draw();
}

function fnChartAddSeriesNotDraw(obj, data,dataNm, valueNm,colNm){
	var type= fnChartType(obj,"IBChartType.COLUMN");
	var series = obj.CreateSeries();
	series.SetProperty({                                          
		 Type:type                      
	 });                      
	series.AddPoints(data);                                                                    
	series.SetName(colNm);	
	obj.AddSeries(series);
	obj.SetXAxisLabelsText(0, dataNm);               
}

function fnChartDraw(obj, data,type){
	obj.SetBaseOptions({
	    Type:type,
		ZoomType:'xy'
		},1);
	setTimeout(function(){
		
		//데이터 조회 시작
		var jsonData = {Data:[]};
		for(var point=0;point<data.DATA[0].DATA.length;point++){
			var p = {};
			//x축 레이블
			p.AxisLabel = data.DATA[0].DATA[point].Name;
			
			var series = [];
			for(var s=0;s<data.DATA.length;s++){
				if(point==0){
					series.push({SeriesName:data.DATA[s].TITLE,Value:data.DATA[s].DATA[point].Y});
				}else{
					series.push(data.DATA[s].DATA[point].Y);
				}
			}
			p.Series= series;
			jsonData.Data.push(p);
		}
		obj.LoadSearchData({IBChart:jsonData});
		//데이터 조회 끝
		
		obj.SetNumericSymbols(["천","백만","십억","조"]); 
		obj.Draw();
	},10); 
}



function YAxisDesignDefault(chart) {
		var Yaxis = chart.GetYAxis(0);
		Yaxis.SetOptions({
			Title:{
				Enabled:false
				,Text:""
			}
			,Formatter:AxisLabelsFormatter
		});
	}

//function YAxisDesignDefault(obj) {
//	var Yaxis = obj.GetYAxis(0);
//	var axislabels = new AxisLabels();
//	axislabels.SetFormatter(AxisLabelsFormatter);
//	Yaxis.SetLabels(axislabels);
//}


function YAxisDesignStacking(chart) {
		var Yaxis = chart.GetYAxis(0);
		Yaxis.SetOptions({
			Max : 100,
			Title:{
				Enabled:false
				,Text:""
			}
			,Formatter:PercentAxisLabelsFormatter
		});
	}
//function YAxisDesignStacking(obj) {
//	var Yaxis = obj.GetYAxis(0);
//	Yaxis.SetMax(100);
//	var axislabels = new AxisLabels();
//	axislabels.SetFormatter(PercentAxisLabelsFormatter);
//	Yaxis.SetLabels(axislabels);
//}

function PieDataLabelsFormatter() {
	return this.point.name + ': ' + this.y ;
}

function PercentAxisLabelsFormatter() {
	return this.value + "%";
}

function AxisLabelsFormatter() {
	return this.value;
}
             


// 추가(2014.11.4)
function initXaxisChart(obj, xlncd, ylncd,lxtitNm){			//X축 스타일
	var Xaxis = obj.GetXAxis(0);      
	Xaxis.SetGridLineColor(xlncd);	//축선색상(그리드 선 색상)
	Xaxis.SetLineColor(ylncd); 	//격자색상(눈금 색상)
	Xaxis.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
	Xaxis.SetAxisTitle(new AxisTitle().SetStyle(new Style().SetFontFamily("Dotum").SetColor("#15498B")));
	Xaxis.SetAxisTitleText(lxtitNm);			
}

function initYaxisChart(obj, xlnCd, ylnCd, lytitNm){		// 왼쪽 Y축 스타일
	initYStyleChart(obj, xlnCd, ylnCd, lytitNm);   
}

function initRYaxisChart(obj, xlnCd, ylnCd, rytitNm){		// 오른쪽 Y축 스타일
	if(rytitNm != ""){
		var Yaxis1 = obj.GetYAxis(1);
		Yaxis1.SetOpposite(true);
		Yaxis1.SetGridLineDashStyle("dot");
		Yaxis1.SetGridLineColor(xlnCd);	//그리드 선 색상(축선)
		Yaxis1.SetLineColor(ylnCd);	//눈금색상(격자)
		Yaxis1.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
		Yaxis1.SetAxisTitle(new AxisTitle().SetStyle(new Style().SetFontFamily("Dotum").SetColor("#15498B")));
		Yaxis1.SetAxisTitleText(rytitNm);
		Yaxis1.SetLabels(new AxisLabels().SetStyle(new Style().SetFontFamily('Dotum')));
	}
}

function initToolTipStyle(obj){		//툴팁 스타일
	var tooltip = new ToolTip();
	tooltip.SetFormatter(ToolTipFormatter);
	tooltip.SetStyle(new Style().SetFontFamily("Dotum"));
	obj.SetToolTip(tooltip);
}

function initLegendStyle(obj,seriesPosx,seriesPosy,seriesOrd,seriesFyn){		//범례 스타일
	var legend = new Legend();
	legend.SetItemStyle(new Style().SetColor("#15498B").SetFontFamily("Dotum"));
	legend.SetItemHiddenStyle(new Style().SetFontFamily("Dotum"));
	legend.SetItemHoverStyle(new Style().SetColor("#15498B").SetFontFamily("Dotum"));
	legend.SetAlign(seriesPosx);		//가로위치
	legend.SetVerticalAlign(seriesPosy);	//세로위치
	legend.SetLayout(seriesOrd);	//정렬
	if("Y" == seriesFyn){
		legend.SetFloating(true);	//플로팅여부
	}else{
		legend.SetFloating(false);	//플로팅여부
	}
	obj.SetLegend(legend);
}

function initLableStyle(obj){		//Label 스타일
	var style = new Style().SetColor("#15498B").SetFontFamily("Dotum").SetFontWeight("bold");
	obj.SetLabelsStyle(style);
}


function initToolTipStyle2(obj){		//툴팁 스타일
	var tooltip = new ToolTip();         
	tooltip.SetFormatter(ToolTipFormatter2);
	tooltip.SetStyle(new Style().SetFontFamily("Dotum"));
	obj.SetToolTip(tooltip);
}

function ToolTipFormatter2() { 
	return '<b>' + this.point.name + '</b><br/>' + this.series.name + ' : ' + commaNumNew(this.y);
}


function commaNumNew(num) {                         
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');                 
}   


             