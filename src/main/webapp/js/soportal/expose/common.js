/*
 * JavaScript String ��ü�� �޼ҵ� �߰�
 * �����޼���(anchor(),big(),blink(),bold(),charAt(),charCodeAt(),concat(),fixed(),fontcolor(),
 * fontsize(),fromCharCode(),indexOf(),italics(),lastIndexOf(),link(),match(),replace(),search(),
 * slice(),small(),split(),strike(),sub(),substr(),substring(),sup(),toLowerCase(),toUpperCase(),toSource(),valueOf()
 */

/*
comment : ���ڿ��� null �� üũ
*/
String.prototype.isEmpty  = function(){
	return ( ( this == null ) || ( this.trim().length == 0 ))
};


/*
comment : ���ڿ��� ������ �������� length��ŭ char�� ġȯ
*/
String.prototype.padLeft = function ( length, char ){	
	if ( ( (! length ) || ( length < 1 ) ) || ( this.isEmpty() ) )
		return this;

	var padding = '                                                                                                    ';

	if ( char )
	{	
		padding = padding.replace( / /g, char );
	}
	return ( padding.substr ( 0, length ) + this );
};

/*
comment : ���ڿ����� ����� �����Ѵ�. 
*/
String.prototype.trim = function(){
	return this.replace(/^\s*|\s*$/gi, '');
};

/*
comment : ���ڿ��� �߰��Ѵ�.
 */
String.prototype.append = function(str){
	return this + str;
};


/*
comment : ���ڿ��� �߰��ϰ� �ٳ���(\n)�� �߰��Ѵ�. 
 */
String.prototype.appendLine = function(str){

	if(!str.isEmpty())
		return this + str + "\n";
	return this;
};

/*
comment : ��ҹ��ڸ� �������� �ʰ� Ư�� ���ڿ��� ��ġ �˻�(indexOf �� ��)
 */
String.prototype.searchString = function(str){
	var thisTemp = this.toLowerCase();
	var strTemp = str.toLowerCase();
	
	return thisTemp.indexOf(strTemp);
};

String.prototype.isContain = function(str){
	return this.searchString(str) != -1;
};


/*
comment : ���ڿ����� Ư�� ����(str)�� �ݺ��Ǿ� ������ Ƚ����ȯ
 */
String.prototype.countString = function(str){
	var count = 0;
	var pos = this.indexOf(str, 0);
	
	while(pos != -1){
		count++;
		pos = this.indexOf(str, pos+1);
	}	
	return count;
};

/*
comment : ��θ� ������ ���ڿ����� Ȯ���� �κ��� ��ȯ�Ѵ�.
 */
String.prototype.getExtension = function(){
	var pos = this.lastIndexOf(".");
	
	return this.substring(pos+1);
};

/*
comment : ���ϸ��� ��ȯ�Ѵ�.
 */
String.prototype.getFileName = function(){
	var pos = this.lastIndexOf("/");
	return this.substring(pos+1);
};

String.prototype.isForbid = function(forbiden){
	// ��� �±� ����
	var source = this.replace(/(<[//]?[^>]+>)/gi,'');		
	var pattern = eval('/' + forbiden + '/gi');
	
	return pattern.test(source);
};

/*
comment : ���ڸ� ��ȯ�Ѵ�.
 */
String.prototype.num = function(){
	return (this.trim().replace(/[^0-9]/g,""));
};


function fn_Next(current,next,length)
{
	if(typeof(current) != "object")
		current = $(current);
	if(typeof(next) != "object")
		next = $(next);
			
	if(current.value.trim().length == length)
		next.focus();
}


function processKey(evt) 
{   
   
    var evt = event;
    	
	var node = (evt.target != null) ? evt.target : ((evt.srcElement != null) ? evt.srcElement : null);
		
    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode >= 112 && event.keyCode <= 123) || (event.keyCode == 8 && node.type!="text" && node.type != "textarea" && node.type != "password")) 
    {   
		event.keyCode = 0; 
		event.cancelBubble = true; 
		event.returnValue = false; 
    }
    
    if ((evt.keyCode == 13) && (node.type=="text") ) {return false;}
			
	if ((evt.keyCode == 13) && node.type == null)
	{
		event.returnValue = false;
	}
}
document.onkeydown = processKey; 


function sleep(naptime){
	naptime = naptime * 1000;
      var sleeping = true;
      var now = new Date();
      var alarm;
      var startingMSeconds = now.getTime();
      
      while(sleeping){
         alarm = new Date();
         alarmMSeconds = alarm.getTime();
         if(alarmMSeconds - startingMSeconds > naptime){ sleeping = false; }
      }      
      alert("Wakeup!");
}


//�Լ���: fn_checkLength(obj, len, str)
//��  ��: ���ڿ��� ���̿� �� ó�� �Լ�
//��  ��: obj : �ش� ��ü, len : ��������, str: �׸��
//--------------------------------------------------------------------------------------------
//����:
//       <textarea name="ta" rows="4" cols=20 class="td_input" style="width:100%"  onblur= "fn_checkLength(this, 100, '�׸�')" >
//			</textarea>
//--------------------------------------------------------------------------------------------
function fn_checkLength(obj, len, str)
{
    obj.value = obj.value.trim();
    complen = fn_checkByte(obj.value);
    if ( complen > len)
    {
        alert(str + len + 'Byte�� �ʰ��Ҽ� ����ϴ�. ���� ' + complen + 'Byte�Դϴ�.');
        obj.focus();
        return false;
    }
    return true;
}

//�Լ���: fn_checkByte(str)
//��  ��: ������ ��ü�� ���ڿ��� ���̸� ����ϴ� �κ�
//��  ��: str : ����
function fn_checkByte(str)
{
	var byteLength= 0;
	for(var inx=0; inx < str.length; inx++)
	{
		var oneChar = escape(str.charAt(inx));
		if( oneChar.length == 1 )
			byteLength ++;
		else if(oneChar.indexOf("%u") != -1)
			byteLength += 2;
		else if(oneChar.indexOf("%") != -1)
			byteLength += oneChar.length/3;
	}
	return byteLength;
}

/*
	* comment : cellIdx ���� �������� �������� merge
	param
	table : ����Ʈ ��ü, �Ǵ� ID
	startRowIdx : ������ ������ row�� Index
	cellIdx : ���� ��� cell Index
	*/
function mergeVerticalCell(table, startRowIdx, cellIdx){

	if(typeof(table) == 'string')
		table = document.getElementById(table);

	var rows = table.getElementsByTagName('tr');
	var numRows = rows.length;
	var numRowSpan = 1;
	var currentRow = null;
	var currentCell = null;
	var currentCellData = null;
	var nextRow = null;
	var nextCell = null;
	var nextCellData = null;

	for(var i = startRowIdx; i < (numRows-1); i++){
		if(numRowSpan <= 1){
			currentRow = table.getElementsByTagName('tr')[i];
			currentCell = currentRow.getElementsByTagName('td')[cellIdx];
			currentCellData = getCellValue(currentCell);
		}

		if(i < numRows - 1){
			if(table.getElementsByTagName('tr')[i+1]){
				nextRow = table.getElementsByTagName('tr')[i+1];
				nextCell = nextRow.getElementsByTagName('td')[cellIdx];
				nextCellData = getCellValue(nextCell);
			}

			if(currentCellData == nextCellData){
				numRowSpan += 1;
				currentCell.rowSpan = numRowSpan;
				nextCell.style.display = 'none';
			}else{
				numRowSpan = 1;
			}
		}
	}
}

/*
	* comment : basicCellIdx �������� �����Ǿ� �ִ� ����Ʈ���� Ư�� cellIdx�� cell�� �ٽ� merge�Ѵ�.
	param
	table : ����Ʈ ��ü, �Ǵ� ID
	startRowIdx : ������ ������ row�� Index
	basicCellIdx : ���� ���� cell�� Index
	cellIdx : ���� ��� cell Index
	*/
function mergeDependentVerticalCell(table, startRowIdx, basicCellIdx, cellIdx){

	if(typeof(table) == 'string')
		table = document.getElementById(table);
		
	var rows = table.getElementsByTagName('tr');
	var numRows = rows.length;
	var numRowSpan = 1;
	var countLoopInBasicMerge = 1;
	var currentRow = null;
	var currentCell = null;
	var currentCellData = null;
	var nextRow = null;
	var nextCell = null;
	var nextCellData = null;
	var basicRowSpan = null;

	for(var i = startRowIdx; i < (numRows - 1); i++){

		if(i == startRowIdx || (countLoopInBasicMerge == 1)){
			basicRowSpan = table.getElementsByTagName('tr')[i].getElementsByTagName('td')[basicCellIdx].rowSpan;
		}
		if(numRowSpan <= 1){
			currentRow = table.getElementsByTagName('tr')[i];
			currentCell = currentRow.getElementsByTagName('td')[cellIdx];
			currentCellData = getCellValue(currentCell);
		}

		if(i < numRows - 1){
			if(countLoopInBasicMerge < basicRowSpan)
			{
				if(table.getElementsByTagName('tr')[i+1]){
					nextRow = table.getElementsByTagName('tr')[i+1];
					nextCell = nextRow.getElementsByTagName('td')[cellIdx];
					nextCellData = getCellValue(nextCell);

					if(currentCellData == nextCellData){
						numRowSpan += 1;
						currentCell.rowSpan = numRowSpan;
						nextCell.style.display = 'none';
					}
					else
					{
						numRowSpan = 1;
					}
				}

				countLoopInBasicMerge++;
			}
			else{
				countLoopInBasicMerge = 1;
				numRowSpan = 1;
			}
		}
	}
}

/*
comment : cell �� ��������
*/
function getCellValue(cell){
	var cellText = '';
	
	if(typeof(cell) == 'undefined')
		return cellText;

	if( typeof(cell.tagName) == 'undefined' ){
		cellText = cell.data;
	}
	else{
		cellText = cell.innerText;
	}
	return cellText;
}

function fn_enterChk() {
	if (event.keyCode == 13) {
	    event.keyCode = 0 ;
	    return true;
    }
    return false;
}
/*
comment : url �̵�
*/
function fn_goUrl(url)
{
	location.href = url;
}

/*
comment : ����Ʈ üũ�ڽ� All Check/ All UnCheck
sample : javascript:fn_checkAll2(this,'chkItem');
param
 - chk : this
 - objnm : üũ��� object name 
*/
function fn_checkAll2(chk,objnm) 
{
	var checkval = chk.checked;

	var chkObj = $s(objnm);
	
	for(var i=0; i<chkObj.length; i++)
	{
		if(!chkObj[i].disabled){
			chkObj[i].checked = checkval;
		}
	}
		
}

/*
 * �߰�
 */

//trim() ��� �Լ� 
function fn_trim(str){
   str = str.replace(/(^\s*)|(\s*$)/g, "");
   return str;
}

// "input type=text" enter key ó��
function fn_keyCheck(){ 
	var check = false; 
   	if(event.keyCode == "13" || event.which == "13"){ 
		check = true; 
    } 
   	return check;
}

//���� �Է� üũ
function fn_onlyNumeric(str)
{
 var findStr = str.match(/[0-9]+/);
 if ( str == findStr ) return true;
 else return false;
}

// document.getElementById(elementId)
function fn_getId(elementId){
	var obj = document.getElementById(elementId);
	return obj;
}

// document.getElementByName(elementName);
function fn_getName(elementName){
	var obj = document.getElementByName(elementName);
	return obj;
}

function fn_DefaultSelected(id, value){
	var obj = fn_getId(id);
	var val = fn_getId(value);
	var len = obj.length;
	for(var i=0;i<len;i++){
		if(obj[i].value == val.value){
			obj[i].selected = true;
		}else{
			obj[i].selected = false;
		}
	}
}
function fn_DefaultChecked(name, value){
	var obj = eval('document.form.'+name);
	var val = fn_getId(value);
	var len = obj.length;
	for(var i=0;i<len;i++){
		if(obj[i].value == val.value){
			obj[i].checked = true;
		}else{
			obj[i].checked = false; 
		}
	}
	if(val.value==''){
		obj[0].checked = true;
	}
}

function fn_onlyNumberChk(obj){
	
	if(fn_trim(obj.value).length != 0 && !fn_onlyNumeric(obj.value)){
		alert("숫자만 입력하세요.");
		obj.value = "";
		return;
	}
}


function fn_onlyNumber(obj){
	//backspace
	if(event.keyCode == "8" || event.which == "8"){
		return;
	}
	//tab
	if(event.keyCode == "9" || event.which == "9"){
		return;
	}
	//shift
	if(event.keyCode == "16" || event.which == "16"){
		return;
	}
	//delete
	if(event.keyCode == "46" || event.which == "46"){
		return;
	}
	if(!fn_onlyNumeric(obj.value)){
		alert("���ڸ� �Է��ϼ���.");
		obj.value = "";
		return;
	}
	
}

//Byte üũ
function fn_byteCheck(val, id){
	var frm = document.form;
	var temp_estr = escape(val);
	var s_index = 0;
	var e_index = 0;
	var temp_str = "";
	var cnt = 0;
	while((e_index = temp_estr.indexOf("%u", s_index)) >=0){
		temp_str += temp_estr.substring(s_index, e_index);
		s_index = e_index + 6;
		cnt ++;;
	}
	temp_str += temp_estr.substring(s_index);
	temp_str = unescape(temp_str);
	fn_getId(id).value = ((cnt *2) + temp_str.length);
	return ((cnt *2) + temp_str.length);
}


function fn_pathDelete(id){
	var a = fn_getId(id);
	a.innerHTML = "<img src='../../images/soportal/expose/btn_plus.gif' alt='�����߰�' title='�����߰�' onClick='addRow()'/> ";
	a.innerHTML += " <input type='file' name='file' id='file' title='�����߰�' style='width:80%;'  onkeypress='return false;'> ";
	//a.select();  
    //document.execCommand('Delete');

}
function fn_pathDelete1(id){
	var a = fn_getId(id);
	a.outerHTML = a.outerHTML
}