

	// 문서 작성
	document.querySelector("#saveBtn").addEventListener('click', async () => {
		let formData = new FormData(document.forms[0]);
		let jsonData = {};
//		formData.forEach((value, key) => {
//			jsonData[key] = value;
//		});
//		jsonData["approval_content"] = editor.getData();
		let d = approvalLine.map((item)=> ({approver_empno:item.id})); 
	    console.log(d[0].approver_empno);
	    console.log(d.length);
	    for(let i = 0; i<d.length; i++){
			formData.append("approvalLineDtos["+i+"].approver_empno",d[i].approver_empno)
		}
//	    jsonData["approvalLineDtos"] = d; 
//	    console.log(jsonData);
		let refData = referenceLine.map((item)=> ({empno:item.id}));
		for(let i = 0; i<refData.length; i++){
			formData.append("approvalReferenceDtos["+i+"].empno",refData[i].empno);
		}
	    formData.append("approval_content", editor.getData());
	    console.log([...formData]);
	    
//	    let response = await fetch("./approvalDocumentSave.json", {
//			method:'POST',
//			body:formData
//		})
//		if(!response.ok) throw new Error ("저장실패");


		let data = await approvalDocumentSave('./approvalDocumentSave.json',formData);
		if(data == true){
            Swal.fire("작성성공").then(()=>{
				location.href='./approvalList.do'
			});
        } else{
            Swal.fire("작성실패");
        }
		
//        let data = await approvalDocumentSave('./approvalDocumentSave.json',jsonData);
        
//		
	});

	document.querySelector("#tempBtn").addEventListener('click', async () => {
		let formData = new FormData(document.forms[0]);
		let jsonData = {};
		formData.forEach((value, key) => {
			jsonData[key] = value;
		});

		if(editor.getData() == '') {
			Swal.fire("문서양식을 선택해주세요");
			return;
		}
		jsonData["approval_content"] = editor.getData();
		
		if( approvalLine.length != 0){
			let d = approvalLine.map(item => ({approver_empno:item.id}));
		    jsonData["approvalLineDtos"] = d; 
		}		

	    console.log(jsonData);

        let data = await approvalDocumentSave('./approvalDocumentSaveTemp.json',jsonData);
        if(data == true){
            Swal.fire("작성성공");
        } else{
            Swal.fire("작성실패");
        }
	})

	document.querySelector("#getContent").addEventListener('click',() => {
		$(".ck-editor").hide();
		$("#fileDiv").show();
		let contentDiv = document.querySelector("#editor")
		contentDiv.style.display = 'block';
		contentDiv.innerHTML = editor.getData();
		let content = document.querySelector("#contentHtml");
		document.querySelector(".modal-body").innerHTML = content.innerHTML;
	});
	