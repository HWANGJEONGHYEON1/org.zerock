<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/10
  Time: 8:33 오후
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/reply.js"></script>
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
                <button id="btnModify" data-oper="modify" class="btn btn-primary" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                <button id="btnList" data-oper="list" class="btn btn-info">List</button>
            </div>
        </div>

    </div>
</div>
<form id="openForm" action="/board/modify" method="get">
    <input type="hidden" name="bno" id="bno" value="<c:out value='${board.bno}' />" />
    <input type="hidden" name="pageNum" id="pageNum" value="<c:out value='${cri.pageNum}' />" />
    <input type="hidden" name="amount" id="amount" value="<c:out value='${cri.amount}' />" />
</form>

<script type="text/javascript">
    console.log("=========");
    console.log("JS TEST");
    let bnoValue = '<c:out value="${board.bno}" />';
    console.log(bnoValue);
    replyService.add(
        {reply: "JS Test", replyer: "tester", bno:bnoValue},
        function (result){
            alert("Result : " + result);
        }
    )
    $("button").on("click", function(e){
        e.preventDefault();
        let openForm = $("#openForm");
        console.log(e.target.id);
        if(e.target.id == 'btnList') openForm.attr("action", "/board/list");
        else openForm.attr("action", "/board/modify");
        openForm.submit();
    })

</script>

<%@include file="../includes/footer.jsp"%>

