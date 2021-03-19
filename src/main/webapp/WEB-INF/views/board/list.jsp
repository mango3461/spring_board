<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko-kr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>list.jsp   </title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

  </head>
<body>
 <div class="container">
 	<br>
 	<h1 style="text-align: center;"> 게시판 </h1>
 	<br><br>
	<table class="table table-hover">
	<thead>
		<tr>
		 <th>번 호</th>
		 <th>제 목</th>
		 <th>글쓴이</th>
		 <th>작성일</th>
		 <th>수정날짜</th>
		</tr>
    </thead>
    <c:forEach items="${list }" var="list">
	    <tr>
		  <td>${list.bno}</td>
		  <td><a href="http://localhost:8181/board/get?bno=${list.bno}">${list.title}</a></td>
		  <td>${list.writer}</td>
		  <td>${list.regDate}</td>
		  <td>${list.updateDate}</td>
	    </tr>
    </c:forEach>
	</table>
	<hr>
  <ul class="pagination justify-content-center">
    <li class="page-item disabled"><a class="page-link" href="#">«</a></li>
    <li class="page-item active"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item"><a class="page-link" href="#">5</a></li>
    <li class="page-item"><a class="page-link" href="#">»</a></li>
  </ul>
  <a href="http://localhost:8181/board/register" class="btn btn-primary right" 
  		style="float: right;" role="button">글쓰기</a>
  		
</div>
</body>
</html>