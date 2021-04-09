<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
<title>get.jsp</title>
<style type="text/css">
	#modDiv {
		width: 300px;
		height: 100px;
		background-color: yellow;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
	}
</style>
</head>
<body>
	<div class="container">
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
			<c:if test="${login.uname == board.writer }">
				<button type="submit" data-oper="modify" class="board btn btn-warning">수정</button>
				<button type="submit" data-oper="remove" class="board btn btn-danger">삭제</button>
			</c:if>
			
	<%-- 		<a href="http://localhost:8181/board/modify?bno=${board.bno}" class="btn btn-outline-warning" role="button">수정</a> --%>
	<%-- 		<a href="http://localhost:8181/board/remove?bno=${board.bno}" class="btn btn-outline-danger" role="button">삭제</a> --%>
		</form>
		<div class="row">
			<h3 class="text-primary">댓글</h3><br>
				<div id="replies">
					<!-- 댓글이 들어갈 위치 -->
				</div>
				<ul class="pagination">
					<!-- 댓글 페이지네이션 -->
				</ul>
		</div><!-- row -->
		<c:if test="${not empty login }">
			<div class="row box-box-success">
				<div class="box-header">
					<h2 class="text-primary">댓글 작성</h2>
				</div><!-- header -->
				<div class="box-body">
					<strong>Writer</strong>
					<input type="text" value="${login.uname }" id="newReplyer" 
							placeholder="Replyer" class="form-control" readonly>
					<strong>ReplyText</strong>
					<input type="text" id="newReplyText" placeholder="ReplyText" class="form-control">
				</div><!-- body -->
				<div class="box-footer">
					<button type="button" class="btn btn-success" id="replyAddBtn">Add Reply</button>
				</div>
			</div>
		</c:if>
		<c:if test="${empty login }">
			<div class="box-body">
				<div><a href="/user/login">Login Please</a></div>
			</div>
		</c:if>
				<!-- 모달 창 위치 -->
		<div id="modDiv" style="display:none;">
			<div class="modal-title"></div>
			<div>
				<input type="text" id="replytext">
			</div>
			<div>
				<button type="button" id="replyModBtn">Modify</button>
				<button type="button" id="replyDelBtn">Delete</button>
				<button type="button" id="closeBtn">Close</button>
			</div>
		</div>
	</div><!-- container -->
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
			$('.board').on("click", function(e){
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
				} else {
					$(".uploadResult ul li").each(function(i, obj) {
						var jobj = $(obj);
					
					})					
				}
				
				// 조건문이 다 돌면 제출되도록 처리하는 코드
				formObj.submit();
			});
	
			var bno = ${board.bno};
			
			function getAllList() {
				
				// rest 주소에 데이터를 요청하고 받아온 데이터를 data변수에 담아준다.
				$.getJSON("/replies/all/" + bno, function(data){
					
// 					console.log(data.length);
		
					// <ul> 내부에 집어넣을 <li> 요소를 그리기 위해 사용
					var loginBool = "${login.uname}";
					var str = "";
					
					// 자바의 forEach와 유사한 구문.
					// data내부의 요소들을 하나하나 순서대로 뽑아서
					// 내부 코드를 실행합니다.
						// 특정요소.html("문자열"); 을 실행하면
						// <>문자열</> 과 같이 태그사이에 넣을 문자열을
						// 지정할 수 있고, 그 문자열은 실제로 삽입될 때는
						// html요소로 간주되어 들어갑니다.
						// ul태그 내에 li형태로 댓글정보를 넣기 위해
						// 아래와 같이 설정합니다.
						
					$(data).each(function(){
						var timestamp = this.updatedate;
						var date = new Date(timestamp);
						
						var formattedTime = "게시일 : " + date.getFullYear()
											+ "/" + (date.getMonth() + 1)
											+ "/" + date.getDate();
						if(this.replyer === loginBool){							
							str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
								+ this.replyer + "</strong> - " + formattedTime + "<br>"
								+ "<div class='replytext'>" + this.replytext + "</div>"
								+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
								+ "</div>";
						} else {
							str += "<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
							+ this.replyer + "</strong> - " + formattedTime + "<br>"
							+ "<div class='replytext'>" + this.replytext + "</div>"
							+ "</div>";
						}
					});
					// id값이 replies인 ul 사이에 문자열을 끼워넣는 문법
					$("#replies").html(str);
				});
			}// getAllList
// 			getAllList();
			
			function getPageList(page){
				$.getJSON("/replies/" + bno + "/" + page, function(data){
//	 				console.log(data.list.length);
					var str = "";
					
					$(data.list).each(function(){
						str += "<li data-rno='" + this.rno + "' class='replyLi'>"
							+ this.rno + ":" + this.replytext
							+ "<button class='btn btn-info'>MOD</button></li>";
					});
					$("#replies").html(str);
					
					printPaging(data.pageMaker);
				}); 
			}//getPageList
 			getPageList(${cri.page});
			
			function printPaging(pageMaker) {
				var str = "";
				
				if(pageMaker.prev){
					str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
				}
				
				for(var i = pageMaker.startPage, len=pageMaker.endPage; i<=len; i++) {
					var strClass = pageMaker.cri.page == i ? 'class=active':'';
					str += "<li class='page-item' " + strClass + "><a class='page-link' href='" + i + "'>" + i + "</a></li>";
				}
				
				if(pageMaker.next) {
					str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
				}
				$(".pagination").html(str);
			}//printPaging
			
			$(".pagination").on("click", "li a", function(e){
				e.preventDefault();
				console.log(this);
				replyPage = $(this).attr("href");
				console.log(replyPage);
				getPageList(replyPage);
			})
			
			$("#replyAddBtn").on("click", function(){
				var replyer = $("#newReplyer").val();
				var replytext = $("#newReplyText").val();
				
				$.ajax({
					type : 'post',
					url : '/replies',
					headers: {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'text',
					data : JSON.stringify({
						bno : bno,
						replyer : replyer,
						replytext : replytext
					}),
					success : function(result) {
						if(result === 'SUCCESS') {
							
							alert("등록 되었습니다.");
							// input 태그 내부를 비움
							$("#newReplyer").val("");
							$("#newReplyText").val("");
							// location.href : 현재 페이지를 이 주소 옮기겠다.
							// 에러가 났을 때 원인이 뭔지 모를때
// 							location.href="/board/get?bno=" + bno
// 										+ "&page=" + "${cri.page}"
// 										+ "&searchType=" + "${cri.searchType}"
// 										+ "&keyword=" + "${cri.keyword}"
							getAllList();
						}
					}
				})
			}) 
			
			// 이벤트 위임
			// 위임은 여러 요소를 독립적으로 기능시키면서도 하나의 이벤트로 처리할 때 
			// 사용하는 개념으로 아래와 같이 "button"이 클릭의 대상일 때
			// 버튼을 모두 포함하고 있는 가장 가까운 부모쪽 태그를 onclick의 타겟으로
			// 잡고 대신 2번째 파라미터에 최종 버튼과 그 사이의 요소를 기술합니다.
			$("#replies").on("click", ".replyLi button", function(){
				// "클릭한 버튼"의 부모요소만 특정지어 가져옴
				var reply = $(this).parent();
				
				// .attr()는 파라미터를 하나 받은 경우 해당 속성의 값을 가져옴
				var rno = reply.data("rno");
				// .text()는 해당 태그의 < 와 > 사이의 모든 자료를 삭제하고
				// 남는 요소만 가져옴
				var replytext = reply.children('.replaytext').html();
				console.log(rno);
				// 댓글 내에 들어있던 rno와 본문이 잘 가져와지는지 확인
	// 			alert(rno + " : " + replytext);
				$(".modal-title").html(rno);
				$("#replytext").val(replytext);
				$("#modDiv").show("slow");
			})
			
			// 삭제 버튼 작동
			$("#replyDelBtn").on("click", function(){
				var rno = $(".modal-title").html();
				var replytext = $("#replytext").val();
				
				$.ajax({
					type : 'delete',
					url : '/replies/' + rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					success : function(result) {
						console.log("result: " + result);
						if(result === 'SUCCESS') {
							alert("삭제 되었습니다.");
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
				})
			})
			
			// 수정 버튼 작동
			$("#replyModBtn").on("click", function(){
				var rno = $(".modal-title").html();
				var replytext = $("#replytext").val();
				
				$.ajax({
					type : 'patch',
					url : '/replies/' + rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PATCH"
					},
					contentType : "application/json",
					data : JSON.stringify({replytext:replytext}),
					dataType : 'text',
					success : function(result) {
						console.log("result: " + result);
						if(result === 'SUCCESS') {
							alert("수정 되었습니다.");
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
				})
			})
			// close 버튼 작동
			$("#closeBtn").on("click", function(){
				$("#modDiv").hide("slow");
			})
			
		});//document

	</script>
</html>