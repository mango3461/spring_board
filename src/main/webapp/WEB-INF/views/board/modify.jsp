<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>modify.jsp</title>
</head>
<body>
	<h1>${board.bno }번 글 내용</h1>
	<form action="/board/modifyrun" method="post">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="hidden" name="page" value="${cri.page }">
		글 제목<input type="text" name="title" class="form-control" value="${board.title }"><br>
		글쓴이<input type="text" name="writer" class="form-control" readonly="readonly" value="${board.writer }"><br>
		본문<br>
		<textarea class="form-control" name="content">${board.content }</textarea><br>
		등록날짜<input type="text" class="form-control" readonly="readonly" value=${board.regDate }><br>
		수정날짜<input type="text" class="form-control" readonly="readonly" value=${board.updateDate }>
		<br>
		<input type="submit" class="btn btn-primary" value="제출">
	</form>
</body>
</html>