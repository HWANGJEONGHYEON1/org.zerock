<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>all</title>
</head>
<body>
    <h1>all</h1>
<sec:authorize access="isAnonymous()">
   <a href="/customLogin">로그인</a>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <a href="/customLogout">로그아웃</a>
</sec:authorize>
</body>
</html>
