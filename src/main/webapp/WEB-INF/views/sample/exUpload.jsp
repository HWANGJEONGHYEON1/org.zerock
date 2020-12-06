<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/06
  Time: 9:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8">
</head>
<body>

    <form action="/sample/exUploadPost" method="post" enctype="multipart/form-data">
        <div>
            <input type="file" name="files">
        </div>
        <div>
            <input type="file" name="files">
        </div>
        <div>
            <input type="file" name="files">
        </div>
        <div>
            <input type="file" name="files">
        </div>
        <div>
            <input type="file" name="files">
        </div>
        <div>
            <input type="submit">
        </div>
    </form>

</body>
</html>
