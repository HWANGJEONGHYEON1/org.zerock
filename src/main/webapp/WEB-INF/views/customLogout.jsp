<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Log out</title>
</head>
<body>
<h1>Custom Login out page</h1>

<form method="post" action="/customLogout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div><button>로그아웃</button></div>
</form>
</body>
</html>
