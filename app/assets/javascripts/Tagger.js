function Tagger(tagElement, isQuestion, qaId, userId, tagInput, tagItemAction, isQuestionName, idName, userIdName, tagTitle) {
   	console.log("TAGGER ENTERED")
 	this.tagElement = document.getElementById(tagInput);
	this.isQuestion = isQuestion;
	this.qaId = document.getElementById(qaId);
	this.userId = document.getElementById(userId);
	this.tagInput = document.getElementById(tagInput)
	this.tagItemAction = tagItemAction;
	this.isQuestionName = isQuestionName;
	this.idName = idName;
	this.userIdName = userIdName;
	this.tagTitle = tagTitle;
	
	var obj = this;
	this.xhr = new XMLHttpRequest();

	this.xhr.onreadystatechange = function(){
		obj.xhrHandler();
	}
	this.tagElement.onkeyup = function(event){
		console.log("keyup")	
	//	var evtobj=window.event? event : e //distinguish between IE's explicit event object (window.event) and Firefox's implicit.
		var evtobj = event
		//var key = (e) ? e.which : event.keyCode;
		var unicode=evtobj.charCode? evtobj.charCode : evtobj.keyCode;
		//188 is comma
		if (unicode == 188){
			console.log("sending ajax request");
			obj.sendAjaxRequest();
		}		
	}
}

Tagger.prototype.xhrHandler = function() {
 if (this.xhr.readyState != 4) {
      return;
  }
  if (this.xhr.status != 200) {
      // Handle error ...
      return;
  }
 //console.log(document.getElementById("results"));
 this.tagElement.innerHTML=this.xhr.responseText;
}

Tagger.prototype.sendAjaxRequest = function(){
	var params = this.isQuestionName+"="+encodeURIComponent(this.isQuestion)
		+"&"+this.idName+"="+encodeURIComponent(this.qaId.value)	
		+"&"+this.userIdName+"="+encodeURIComponent(this.userId.value)
		+"&"+this.tagTitle+"="+encodeURIComponent(this.tagInput.value);
	console.log("PARAMETERS"+params);
	this.xhr.open("GET", this.tagItemAction+"?"+params,false); 
	this.xhr.send(params);	
}
