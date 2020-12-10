<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/10
  Time: 8:33 오후
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>

<div class="row">

    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
</div>

<div class="row">

    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board board page</div>
            <div class="panel-body">
                <div class="form-group">
                    <label>Bno</label> <input class="form-control" name="bno"
                                        value="<c:out value='${board.bno}' />" readonly/>
                </div>
                <div class="form-group">
                    <label>Title</label> <input class="form-control" name="title"
                                              value="<c:out value='${board.title}' />" readonly/>
                </div>
                <div class="form-group">
                    <label>Content</label> <input class="form-control" name="content"
                                              value="<c:out value='${board.content}' />" readonly/>
                </div>
                <div class="form-group">
                    <label>writer</label> <input class="form-control" name="writer"
                                              value="<c:out value='${board.writer}' />" readonly/>
                </div>
                <button data-oper="modify" class="btn btn-primary" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                <button data-oper="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>
            </div>
        </div>

    </div>
</div>
<%@include file="../includes/footer.jsp"%>