<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>get.jsp</title>
</head>
<body>
	<h1>${board.bno }번 글 내용</h1>
	<form method="post">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="hidden" name="page" value="${cri.page }">
		<input type="hidden" name="searchType" value="${cri.searchType }">
		<input type="hidden" name="keyword" value="${cri.keyword }">	
		글 제목<input type="text" class="form-control" readonly="readonly" value="${board.title }"><br>
		글쓴이<input type="text" class="form-control" readonly="readonly" value="${board.writer }"><br>
		본문<br>
		<textarea readonly="readonly" class="form-control">${board.content}</textarea><br>
		등록날짜<input type="text" class="form-control" readonly="readonly" value=${board.regDate }><br>
		수정날짜<input type="text" class="form-control" readonly="readonly" value=${board.updateDate }>
		<!-- button태그는 말 그대로 버튼을 만들어주는 태그
		기본적으로는 input태그의 type=submit, reset 등을 쓰듯이 사용하면 됨
		가변적으로 action(목표url)속성을 바꿔주기 위해서
		data-oper 속성을 이용해 어떤버튼을 눌렀는지 함께 정보가 제공되도록 합니다. -->
		<a href="http://localhost:8181/board/list?page=${cri.page}&searchType=${cri.searchType}&keyword=${cri.keyword}"
			 class="btn btn-primary" role="button">목록</a>
		<button type="submit" data-oper="modify" class="btn btn-warning">수정</button>
		<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
		
<%-- 		<a href="http://localhost:8181/board/modify?bno=${board.bno}" class="btn btn-outline-warning" role="button">수정</a> --%>
<%-- 		<a href="http://localhost:8181/board/remove?bno=${board.bno}" class="btn btn-outline-danger" role="button">삭제</a> --%>
	</form>
</body>
<!-- 통상적으로 Javascript 코드는 페이지 제일 마지막에 기술합니다.
이유는 맨 위에 작성할 경우, 자바스크립트 코드가 모두 파싱되어야
그 때부터 html코드가 그려지기 시작하기 때문에
사용자 입장에서 파싱이 늦어지면 사이트가 느리다고 느낄 수 있습니다. 
스크립트릿과 마찬가지로 html코드 사이에 html이 아닌 코드를 삽입하기 위해서 사용합니다.
-->
	<script type="text/javascript">
	// 페이지가 로딩되자마자 버튼 감지 서전준비를 위해 아래와 같이 작성합니다.
	// $document.ready()) 내부의 코드는 페이지가 로딩되는 순간 바로 실행됩니디ㅏ.
		$(document).ready(function() {
			// 제이쿼리가 잘 작동하는지 테스트해봅니다.
// 			alert("제이쿼리 작동!");
			
			// form 태그를 불러옵니다.
			var formObj =$("form");
			
			// 1. form태그의 내용이 제대로 불러왔는지 확인합니다.
			// 확인잉 되었다면 주석처리합니다.
// 			console.log(formObj);
			// 2. form태그의 action부분을 고쳐보겠습니다.
			// .attr은 해당 태그의 속성값을 설정하는것이고
			// .("속성명", "대입할 속성") 순으로 작성합니다.
			// 하기 코드는 form태그의 action(목적주소)를
			// www.cowhdgns.com 으로 변경합니다.
// 			formObj.attr("action", "http://www.cowhdgns.com");
// 			console.log(formObj);
			// 3. 버튼을 클릭했을 때 data-oper값 감지하기.
			// 페이지 로딩완료가 아닌 버튼 클릭시 감지해야 하므로
			// 버튼 클릭 이벤트부터 처리합니다.
			$('button').on("click", function(e){
				// 버튼 클릭시 submit으로 설정되어 있어서
				// 의도와 상관없이 바로 submit을 진행시킴
				// 따라서 그걸 막기 위해 코드 추가
				e.preventDefault();
				
				// 감지 로직
				var operation = $(this).data("oper");
// 				console.log(operation);

				// method 속성은 post로 변경해주시고
	            // 감지된 버튼이 remove인 경우
	            // remove 페이지로 가도록 조건물을 짜 주시고
	            // 버튼이 modify인 경우
	            // modify로 가도록 조건문을 짜주세요
				if(operation === "modify") {
					formObj.attr("action", "http://localhost:8181/board/modify?bno=${board.bno}")
				} else if(operation === "remove") {
					formObj.attr("action", "http://localhost:8181/board/remove?bno=${board.bno}")
				}
				
				// 조건문이 다 돌면 제출되도록 처리하는 코드
				formObj.submit();
			});
		});
	</script>
</html>