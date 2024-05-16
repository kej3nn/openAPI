/**
 * 20190411/JSR
 * 입력 시트에서 난수를 발생하여 데이터를 입력한다.
 */
function randomInput() {
	
	var classObj = $("."+tabContentClass);
	var actObj = setTabForm2(classObj, "statInput-dtl-form");
	var formObj = getTabFormObj("statInput-dtl-form");
	
	riDrawElement();
	
	/**
	 * 난수발생 관련 ELEMENTS를 생성한다.
	 */
	function riDrawElement() {
		var elements = 
		"<tr id=\"randomInput-area\">" +
		"	<th><label>난수입력</label></th>" +
		"	<td colspan=\"3\">" +
		"		<label>최소값 : </label><input type=\"text\" id=\"randomInputMin\" value=\"0\"/>" +
		"		<label>최대값 : </label><input type=\"text\" id=\"randomInputMax\" value=\"10000\"/>" +
		"		<a href=\"javascript:;\" class=\"btn02\" title=\"입력\" name=\"a_randomInput\" style=\"\">입력</a>" +
		"	</td>" +
		"</tr>";
		
		formObj.find("table[class=list01").eq(1).append($(elements));
		
		riAddEvent();
	}
	
	/**
	 * 난수발생 관련 이벤트
	 */
	function riAddEvent() {
		formObj.find("a[name=a_randomInput]").bind("click", function() {
			riDrawValues();
		});
	}
	
	/**
	 * MIN, MAX를 포함하는 난수를 발생시킨다.(소수점 이하는 제거한다.)
	 */
	function getRandomIntInclusive(min, max) {
		return Math.floor(gfn_random() * (max - min + 1)) + min;
	}
	
	/**
	 * 시트에 난수를 입력한다.
	 * 데이터 시작 행, 열부터 데이터 종료 행, 열까지..
	 */
	function riDrawValues() {
		var inputSheetObj = getTabSheetObj("statInput-dtl-form", "inputSheetNm");
		var dataStartRow = inputSheetObj.HeaderRows();
		var dataEndRow = dataStartRow + inputSheetObj.RowCount();
		var dataStartCol = 0;
		var dataEndCol = inputSheetObj.LastCol();

		var randomMin = Number(formObj.find("input[id=randomInputMin]").val()) || 0;
		var randomMax = Number(formObj.find("input[id=randomInputMax]").val()) || 10000;
			
		for ( var i=0; i < dataEndCol; i++ ) {
			var saveName = inputSheetObj.ColSaveName(i);
			if ( saveName.indexOf("iCol_") > -1 ) {
				// 데이터 시작행을 찾는다.
				dataStartCol = i;
				break;
			}
		}
		
		for ( var i=dataStartRow; i < dataEndRow; i++ ) {
			for ( var j=dataStartCol; j <= dataEndCol; j++ ) {
				inputSheetObj.SetCellValue(i, j, getRandomIntInclusive(randomMin, randomMax));
			}
		}
	}
}