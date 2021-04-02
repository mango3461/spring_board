<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinmember.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
</head>
<body>

<form action="joinmember" method="post">
	<div class="container">
		<div class="form-group has-feedback">
			<input type="text" name="uid" class="form-control" placeholder="ID" />
			<span class="glyphion glyphion-envelope form-control-feedback"></span>
			<button id="idCheckBtn">아이디 체크하기</button>
		</div>
		<div class="for-group has-feedback">
			<input type="password" name="upw" class="form-control" placeholder="PW" />
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		</div>
		<div class="for-group has-feedback">
			<input type="text" name="uname" class="form-control" placeholder="NAME" />
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		</div>
		<div>
			<button type="submit" class="btn btn-primary btn-block btn-flat">가입하기</button>
		</div>
	</div>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		$(#"idCheckBtn").on("click", function(){
			$.ajax({
				type : 'post',
				url : '/user/check/' + uidValue,
				headers: {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',				
				success : function(result) {
						if(result.uid === uidValue) {
							str += "아이디 체크 완료";
							$("resultComment").html(str);
						}
						console.log(result);
					},
					error : function(result){
						console.log("에러발생");
					}
				}
		})
	}

</script>
</body>
</html>