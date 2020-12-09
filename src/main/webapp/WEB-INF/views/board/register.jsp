<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/09
  Time: 12:18 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Main Content -->
    <%@include file="../includes/header.jsp"%>

        <h1 class="h3 mb-2 text-gray-800">Board Register</h1>
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Board Register</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <form role="form" action="/board/register" method="post">
                        <div class="form-group">
                            <label>Title</label> <input class="form-control" name="title">
                        </div>
                        <div class="form-group">
                            <label>Text Area</label>
                            <textarea class="form-control" rows="3" name="content"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Writer </label><input class="form-control" name="writer">
                        </div>
                            <button type="submit" class="btn-primary">Submit</button>
                            <button type="reset" class="btn-dark">Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@include file="../includes/footer.jsp"%>