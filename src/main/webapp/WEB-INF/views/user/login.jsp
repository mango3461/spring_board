<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</head>
<body>

<form action="/user/loginPost" method="post">
	<div class="container">
		<div class="form-group has-feedback">
			<input type="text" name="uid" class="form-control" placeholder="ID" />
			<span class="glyphion glyphion-envelope form-control-feedback"></span>
		</div>
		<div class="for-group has-feedback">
			<input type="password" name="upw" class="form-control" placeholder="PW" />
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		</div>
		<div class="row">
			<div class="col-xs-8">
				<div class="checkbox icheck">
					<label>
						<input type="checkbox" name="useCookie">Remember Me
					</label>
				</div>
			</div><!-- .col -->
		</div><!-- .row -->
		<div class="col-xs=4">
			<button type="submit" class="btn btn-primary btn-block btn-flat">Sign in</button>
		</div><!-- .col -->
	</div>

</form>

</body>
</html>