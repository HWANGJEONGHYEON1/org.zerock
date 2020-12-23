<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/08
  Time: 11:21 오후
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-label="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body"> 처리가 완료되었습니다.</div>
            <div class="modal-footer">
                <button type="buttton" class="btn btn-dark" data-dismiss="modal">close</button>
                <button type="button" id="reBtn" class="btn btn-primary">save changes</button>
            </div>
        </div>
    </div>
</div>


                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                    For more information about DataTables, please visit the <a target="_blank"
                                                                               href="/https://datatables.net">official DataTables documentation</a>.</p>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>#번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>수정</th>
                                </tr>
                                </thead>
                               <c:forEach items="${list}" var="board">
                                   <tr>
                                       <td><c:out value="${board.bno}"/></td>
                                       <td><a class="move" href="<c:out value='${board.bno}'/>"><c:out value="${board.title}" />  <b>[<c:out value="${board.replyCnt}"/>]</b></a></td>
                                       <td><c:out value="${board.writer}" /></td>
                                       <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-mm-dd" /></td>
                                       <td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-mm-dd" /></td>
                                   </tr>
                               </c:forEach>
                            </table>
                            <div class="row">
                                <div class="col-lg-12">
                                    <form id="searchForm" action="/board/list" method="get">
                                        <select name="type">
                                            <option value="<c:out value='${pageMaker.cri.type eq null ? "selected" : ""}' />">--</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "T" ? "selected" : ""}' />">제목</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "C" ? "selected" : ""}' />">내용</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "W" ? "selected" : ""}' />">작성자</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "TC" ? "selected" : ""}' />">제목 또는 내용</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "TW" ? "selected" : ""}' />">제목 또는 작성자</option>
                                            <option value="<c:out value='${pageMaker.cri.type eq "TWC" ? "selected" : ""}' />">제목 또는 내용 또는 작성</option>
                                        </select>
                                        <input type="text" name="keyword" value="${pageMaker.cri.keyword}" />
                                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
                                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
                                        <button class="btn btn-primary">Search</button>
                                    </form>
                                </div>
                            </div>
                            <div class="-pull-left">
                                <div class="pagination">
                                    <c:if test="${pageMaker.prev}">
                                        <li class="pagination"><a href="${pageMaker.startPage-1}">Previous</a></li>
                                    </c:if>
                                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                        <li class="page-link ${pageMaker.cri.pageNum == num ? "action" : ""}"><a href="${num}">${num}</a></li>
                                    </c:forEach>
                                    <c:if test="${pageMaker.next}">
                                        <li class="pagination" next><a href="${pageMaker.endPage+1}">next</a></li>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->
<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
    <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
    <input type="hidden" name="type" value="${pageMaker.cri.type}" />
</form>

     <%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function(){
        let result = '<c:out value="${result}" />';
        checkModal(result);
        history.replaceState({},null,null);
        function checkModal(result) {
            if(result == '' || history.state==null) return ;

            if(parseInt(result)>0) $(".modal-body").html('게시글 '+ parseInt(result) + "번이 등록 되었습니다.");

            $("#myModal").modal('show');


        }

        $("#reBtn").on("click", function(){
            self.location = "/board/register";
        });

        let actionForm = $("#actionForm");
        console.log(actionForm);
        $(".page-link a").on("click",function(e){
            e.preventDefault();
            console.log($(this).attr("href"));
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $(".move").on("click", function(e){
            e.preventDefault();
            actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr('href')+"' />");
            actionForm.attr("action", "/board/get");
            actionForm.submit();
        });

        let searchForm = $("#searchForm");

        $("#searchForm button").on("click", function(e){

            if(!searchForm.find("option:selected").val()){
                alert('검색종류를 선택하세요');
                return false;
            }

            if(!searchForm.find("input[name='keyword']").val()){
                alert('키워드를 입력하세요');
                return false;
            }
            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();

            searchForm.submit();
        })

    })
</script>