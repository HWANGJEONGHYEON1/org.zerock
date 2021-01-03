<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/10
  Time: 9:50 오후
  To change this template use File | Settings | File Templates.
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>
<script type="text/javascript">

    $(document).ready(function(){

        (function(){
            let bno = '<c:out value="${board.bno}" />';
            $.getJSON("/board/getAttachList", {bno:bno}, function(arr){
                let str = "";
                $(arr).each(function(i, attach){
                    if(attach.fileType) {
                        let fileCallPath = encodeURIComponent( attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
                        str += "<li data-path='"+attach.uploadPath+"' "
                            + " data-uuid='"+attach.uuid+"' data-filename='"
                            + attach.fileName+"' data-type='"+attach.image+"'>";
                        str += "<div>";
                        str += "<span> "+ attach.fileName + "</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                        str += "<img src='/display?fileName="+fileCallPath+"'>";
                        str += "</div></li>";
                    } else {
                        str += "<li data-path='"+attach.uploadPath+"' "
                            + " data-uuid='"+attach.uuid+"' data-filename='"
                            + attach.fileName+"' data-type='"+attach.image+"'>";
                        str += "<div>";
                        str += "<span> "+ attach.fileName + "</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                        str += "<img src='/resources/img/attach.png'>"
                        str += "</div></li>";
                    }
                });
                $(".uploadResult ul").append(str);
            });
        })();

        $(".uploadResult").on("click", "button", function(e){
            console.log("delete file");
            if(confirm("Remove file ?")){
                let targetLi = $(this).closest("li");
                targetLi.remove();
            }
        })
        const formObj = $('form');
        console.log("modify;;;;;");
        console.log('<c:out value="${cri.pageNum}" />');

        $('button').on('click', function(e){
            e.preventDefault();

            let operation = $(this).data("oper");
            let pageNumTag = $("input[name='pageNum']").clone();
            let amountTag = $("input[name='amount']").clone();
            let keywordTag = $("input[name='keyword']").clone();
            let typeTag = $("input[name='type']").clone();

            if(operation === 'remove'){
                formObj.attr('action','/board/remove');
            } else if(operation === 'list'){

                formObj.attr("action", "/board/list").attr("method","get");
                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(keywordTag);
                formObj.append(typeTag)

            }

            formObj.submit();

        })
    })
</script>

<div class="row">

    <div class="col-lg-12">
        <h1 class="page-header">Board Modify</h1>
    </div>
</div>

<div class="row">

    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board board page</div>
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}" /> "/>
                    <input type="hidden" name="amount" value="<c:out value="${cri.amount}" /> "/>
                    <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}" /> "/>
                    <input type="hidden" name="type" value="<c:out value="${cri.type}" /> "/>
                <div class="form-group">
                    <label>Bno</label> <input class="form-control" name="bno"
                                              value="<c:out value='${board.bno}' />" readonly="readonly"/>
                </div>
                <div class="form-group">
                    <label>Title</label> <input class="form-control" name="title"
                                                value="<c:out value='${board.title}' />" />
                </div>
                <div class="form-group">
                    <label>Content</label> <input class="form-control" name="content"
                                                  value="<c:out value='${board.content}' />" />
                </div>
                <div class="form-group">
                    <label>writer</label> <input class="form-control" name="writer"
                                                 value="<c:out value='${board.writer}' />" readonly/>
                </div>
                <button data-oper="modify" class="btn btn-primary" >Modify</button>
                <button data-oper="remove" class="btn btn-danger" >Delete</button>
                <button data-oper="list" class="btn btn-info">List</button>
                </form>
            </div>
        </div>
        <div class="bigPictureWrapper"><div class="bigPicture"></div></div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header">Files</div>
                    <div class="card-body">
                        <div class="uploadResult">
                            <ul>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<%@include file="../includes/footer.jsp"%>
