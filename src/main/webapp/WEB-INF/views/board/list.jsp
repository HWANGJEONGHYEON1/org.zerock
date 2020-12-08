<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/08
  Time: 11:21 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <!-- Main Content -->
    <%@include file="../includes/header.jsp"%>


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
                                       <td><c:out value="${board.bno}" /></td>
                                       <td><c:out value="${board.title}" /></td>
                                       <td><c:out value="${board.writer}" /></td>
                                       <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-mm-dd" /></td>
                                       <td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-mm-dd" /></td>
                                   </tr>
                               </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

     <%@include file="../includes/footer.jsp"%>