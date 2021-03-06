<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>register.jsp</title>
<style>
.uploadResult {
	width:100%;
	background-color: skyblue;
}
.uploadResult ul {
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items: center;
}
.uploadResult ul li {
	list-style: none;
	padding: 10px;
}
.uploadResult ul li img {
	width: 20px;
}
</style>
</head>
<body>
	<h1>글 작성하기</h1>
	<!-- 타겟 주소(action), 전송방식(method)을 작성해주세요
	그리고, 내부 폼에서는
	input태그의 text로 title 파라미터에 글제목을
	input태그의 textarea로 content 파라미터에 글 내용을
	input태그의 text로 writer 파라미터에 글쓴이를 적은 뒤
	input태그의 submit으로 제출하도록 작성해보세요. -->
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
	<ul>
		<!-- 업로드된 파일이 들어갈 자리 -->
	</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<form action="/board/register" method="post">
		<br><br>
		제목 : <input type="text" class="form-control" name="title" /> <br>
		본문 : <br><textarea class="form-control" name="content"></textarea> <br>
		글쓴이 : <input class="form-control" type="text" name="writer" readonly 
						value="${login.uname }" /> <br>
		<input type="submit" id="writeBtn" class="btn btn-primary" value="제출">
	</form>
	
	<script>
		$(document).ready(function(){
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize) {
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}
			
// 			$('#writeBtn').on("click", function(e){
// 				var formData = new FormData();
			
// 				var inputFile = $("input[name='uploadFile']");
				
// 				var files = inputFile[0].files;
				
// 				console.log(files);
				
// 				for(var i = 0; i < files.length; i++) {
// 					if(!checkExtension(files[i].name, files[i].size)){
// 						return false;
// 					}
// 					formData.append("uploadFile", files[i]);
// 				}
				
// 				$.ajax({
// 					url: 'uploadAjaxAction',
// 					processData: false,
// 					contentType: false,
// 					data: formData,
// 					type: 'POST',
// 					dataType: 'json',
// 					success: function(result) {
// 						console.log(result);
						
// 						showUploadedFile(result);
						
// 						$(".uploadDiv").html(cloneObj.html());
// 					}
// 				})//ajax
// 				$("form").submit();
// 			});//writeBtn
			
			
			var cloneObj = $(".uploadDiv").clone();
			
			$('#uploadBtn').on("click", function(e){
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				// 파일 데이터를 폼에 집어넣기
				for(var i = 0; i < files.length; i++) {
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				console.log(formData);
				
				$.ajax({
					url: 'uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					dataType: 'json',
					success: function(result) {
						console.log(result);
						
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());
					}								
				})//ajax
			})// onclick uploadBtn
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				var str = "";
				
				$(uploadResultArr).each(function(i, obj){
					console.log(i);
					console.log(obj);
					
					if(!obj.fileType) {
						var fileCallPath = encodeURIComponent(
								obj.uploadPath + "/"
								+ obj.uuid + "_" + obj.fileName);
						str += "<li><a href='/download?fileName=" + fileCallPath
								+ "'>" + "<img src='/resources/upload_icon.jpg'>"
							+ obj.fileName + "</a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>" 
							+ "</li>";
					} else {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + 
															obj.uuid + "_" + obj.fileName);
						str += "<li><a href='/download?fileName=" + fileCallPath
							+ "'>" + "<img src='/display?fileName=" + fileCallPath 
							+ "'>" + obj.fileName + "</a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>" 
							+ "</li>";
					}
					
				})
				uploadResult.append(str);
			}//showUploadedFile
			
			$(".uploadResult").on("click", "span", function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type:type},
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove();
					}
				})//ajax
			})//click span
			
			
			
			$("#writeBtn").on("click", function(e) {
				// 1. 버튼기능을 막으세요
				e.preventDefault();
				// 2. var formObj = $("form");로 폼태그를 가져옵니다.
				var formObj = $("form");
				// 3. formObj 내부에 64페이지 장표를 참고해서
				// hidden태그들을 순서대로 만들어줍니다.
				var str = "";
				$(".uploadResult ul li").each(function(i, obj) {
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName'"
						+ " value='" + jobj.data("filename") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uuid'"
						+ " value='" + jobj.data("uuid") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
						+ " value='" + jobj.data("path") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].fileType'"
						+ " value='" + jobj.data("type") + "'>";
						
				})
				// 4. formObj.append()로 추가해줍니다.
				formObj.append(str);
				// 5. formObj.submit()으로 제출합니다.
				formObj.submit();
			})
						
		});//document
	</script>

</body>
</html>