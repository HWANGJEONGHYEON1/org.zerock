<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/09
  Time: 12:18 오전
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript">

    $(document).ready(function(e){
        let formObj = $("form[role='form']");

        $("button[type='submit']").on("click", function(e){

            e.preventDefault();
            console.log("submit clicked");
        })

        let regex = new RegExp("(.*?).(exe|sh|zip|alz)$");
        let maxSize = 5242880; //5mb

        let checkExtension = (fileName, fileSize) => {
            if(fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }

            if(regex.test(fileName)){
                alert("업로드 불가 파일입니다.");
                return false;
            }
            return true;
        }

        let showUploadResult = (uploadResultArr) => {
            if(!uploadResultArr || uploadResultArr.length == 0) return false;

            let uploadUL = $(".uploadResult ul");

            let str = "";

            $(uploadResultArr).each(function(i, obj){
                if(obj.image){

                } else {

                }
            });

            uploadUL.append(str);

        }

        $("input[type='file']").change(function (e){
            let formData = new FormData();
            let inputFile = $("input[name='uploadFile']");
            let files = inputFile[0].files;

            for(let i = 0; i < files.length; i++){
                if(!checkExtension(files[i].name, files[i].size)) return false;
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false,
                data : formData,
                type : 'POST',
                dataType: 'json',
                success : function(result){
                    console.log(result);
                    showUploadResult(result);
                },
                fail : function(e){
                    alert(e);
                }
            });
        })
    })
</script>

<!-- Main Content -->


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
                <div class="table-responsive">
                    <div class="custom-file">File Attach</div>
                    <div class="-file-upload uploadDiv">
                        <input type="file" name="uploadFile" multiple>
                    </div>

                    <div class="uploadResult">
                        <ul></ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@include file="../includes/footer.jsp"%>