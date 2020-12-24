<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/24
  Time: 12:32 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html">
<html>
<head>
    <title></title>
</head>
<body>
    <form action="uploadFormAction" methods="post" enctype="multipart/form-data">
        <input type="file" name="uploadFile" multiple>
        <button>Submit</button>
    </form>
</body>
</html>
