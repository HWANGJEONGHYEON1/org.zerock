<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2021/01/04
  Time: 11:56 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
</head>
<body>
    <h1>Admin</h1>
    <h1>name : <c:out value="${pricipal}"  /></h1>
    <p>principal : <sec:authentication property="principal" /></p>
    <p>MemberVO : <sec:authentication property="principal.member" /></p>
    <p>사용자이름 : <sec:authentication property="principal.member.userName"  /> </p>
    <p>사용자아이디 : <sec:authentication property="principal.username" /> </p>
    <p>사용자 권한 리스트 : <sec:authentication property="principal.member.authList"/></p>


    <a href="/customLogout">Logout</a>
</body>
</html>
