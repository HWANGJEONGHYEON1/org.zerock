<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/10
  Time: 8:33 오후
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-label="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="newReply!">
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="newReplyer!">
                </div>
                <div class="form-group">
                    <label>reply date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalModBtn" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" class="btn btn-primary">Register</button>
                <button id="modalCloseBtn" class="btn btn-dark">Close</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    $(document).ready(function(){
        let bnoValue = '<c:out value="${board.bno}" />';
        let replyUL = $(".-reply");

        showList(1);
        function showList(page) {
            console.log("showlist " ,page );

            replyService.getList({bno:bnoValue,page: page || 1}, function(replyCnt,list){
                let str = [];

                if(page == -1 ){
                    pageNum = Math.ceil(replyCnt / 10.0);
                    showList(pageNum);
                    return ;
                }

                if(list == null || list.length == 0){
                    replyUL.html("");
                    return;
                }
                let len = list.length || 0;
                for(let i = 0 ;  i < len; i++){
                    str.push("<li class = 'left clearfix' data-rno='"+list[i].rno+"'>");
                    str.push(   "<div class='header'>  ");
                    str.push(       "<strong class='font-italic'>" + list[i].replyer + "</strong>");
                    str.push(       "<small class='pull-right text-muted'>"+ replyService.displayTime(list[i].replyDate) + "</small>" );
                    str.push(   "</div>");
                    str.push(    "<p>"+list[i].reply+"</p></li>");
                }
                replyUL.html(str);
                showReplyPage(replyCnt);
            })
        }

        let modal = $(".modal");
        let modalInputReply = modal.find("input[name='reply']");
        let modalInputReplyer = modal.find("input[name='replyer']");
        let modalInputReplyDate = modal.find("input[name='replyDate']");

        let modalModBtn = $("#modalModBtn");
        let modalRemoveBtn = $("#modalRemoveBtn");
        let modalRegisterBtn = $("#modalRegisterBtn");

        $("#addReplyBtn").on("click", function(e){
            modal.find("input").val("");
            modalInputReplyDate.closest("div").hide();
            // modal.find("button[id != 'modalCloseBtn']").hide();

            $(".modal").modal("show");
        });

        modalRegisterBtn.on("click", function(e){
            let reply = {
                reply : modalInputReply.val(),
                replyer : modalInputReplyer.val(),
                bno : bnoValue
            }

            replyService.add(reply, function(result){
                alert(result);

                modal.find("input").val("");
                modal.modal("hide");

                showList(-1);
            })
        });

        modalRemoveBtn.on("click", function (e){
            let rno = modal.data("rno");
            console.log(rno);
            replyService.remove(rno, function(result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            })
        })

        replyUL.on("click", "li", function(e){
            let rno = $(this).data("rno");

            replyService.get(rno, function(reply){
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
                modal.data("rno", reply.rno);

                modal.find("button[id != 'modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            })
        });

        modalModBtn.on("click", function(e){
            let reply = {rno:modal.data("rno"), reply : modalInputReply.val()}
            replyService.update(reply, function(result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            })
        });

        replyService.get(22, function(data){
        })

        let pageNum = -1;
        let replyPageFooter = $('card-footer');

        function showReplyPage(replyCnt){
            let endNum = Math.ceil(pageNum / 10.0) *10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if(endNum * 1 >= replyCnt){
                endNum = Math.ceil(replyCnt/10/0);
            }
            if(endNum * 10 < replyCnt){
                next = true;
            }

            let str = [];
            str.push("<ul class = 'pagination -pull-right' >");
            if(prev){
                str.push("<li class='page-item'><a class='page-link' href='"+ (startNum-1)+"'> Previous </a></li>");
            }

            for(let i = startNum ; i <= endNum ; i++){
                let active = pageNum == i ? "active" : "";
                str.push("<li class='page-item "+active+" '> <a class='page-link' href='"+i+"'> "+i+" </a></li>");
            }

            if(next){
                str.push("<li class='page-item'><a class='page-link' href='"+ (endNum+1)+"'> Next </a></li>");
            }

            str.push("</ul></div>");
            console.log(str);
            replyPageFooter.html(str);
        }

        replyPageFooter.on("click" , function(e){
            e.preventDefault();
            console.log("pageClick");

            let targetPageNum = $(this).attr("href");
            console.log("# taget" + targetPageNum);
            pageNum = targetPageNum;
            showList(pageNum);
        })

    });
</script>


<div class="row">

    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">Board board page</div>
            <div class="card-body">
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

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <i class="fa fa-comments fa-fw"></i>Reply
                <button id="addReplyBtn" class="btn btn-primary btn-sm">New Reply</button>
            </div>
            <div class="card-body">
                <ul class="-reply">
                    <li class="left clearfix" data-rno="12">
                        <div class="header">
                            <strong class="font-italic">user00</strong>
                            <small class="-pull-right text-muted">2020-12-21 </small>
                        </div>
                        <p>Goooood JOOOooooooooob !</p>
                    </li>
                </ul>
                <div class="card-footer"></div>
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

    $("button").on("click", function(e){
        e.preventDefault();
        let openForm = $("#openForm");

        $("button[data-oper='modify']").on("click", function(e){
            openForm.attr("action", "/board/modify").submit();
        })

        $("button[data-oper='list']").on("click", function(e){
            openForm.find("#bno").remove();
            openForm.attr("action", "/board/list").submit();
        })


    })

</script>

<%@include file="../includes/footer.jsp"%>

