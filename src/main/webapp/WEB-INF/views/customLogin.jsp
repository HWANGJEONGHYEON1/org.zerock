<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(".btn-success").on("click", function (e){
        e.preventDefault();

        $("form").submit();
    })
</script>
<html>
<head>

    <title>Login</title>
</head>
<body>
    <h1>Custom Login page</h1>
    <h2><c:out value="${error}" />></h2>
    <h2><c:out value="${logout}" />></h2>

    <form method="post" action="/login">
        <fieldset>
            <div class="form-group">
                <input class="form-control" type="text" name="username" autofocus>
            </div>
            <div class="form-group">
                <input class="form-control" type="password" name="password" value="">
            </div>
            <div class="form-group">
                <input type="checkbox" name="remember-me">Remember me
            </div>

            <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
        </fieldset>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
</body>
</html>
