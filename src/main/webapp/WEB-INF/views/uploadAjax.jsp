<%--
  Created by IntelliJ IDEA.
  User: hwangjeonghyeon
  Date: 2020/12/24
  Time: 12:55 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">

    .uploadResult {
        width:100%;
        background-color:gray;
    }

    .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li {
        list-style: none;
        padding: 10px;
    }
    .uploadResult ul li img{
        width:20px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function(){

        const maxSize = 5242880;
        const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        const cloneObj = $(".uploadDiv").clone();
        const uploadResult = $(".uploadResult");

        let checkExtension = (fileName, fileSize) => {
            if(fileSize >= maxSize) {
                alert('파일 사이즈 초과');
                return false;
            }

            if(regex.test(fileName)){
                alert("해당 종류의 파일은 업로드 불가");
                return false;
            }
            return true;
        }

        let showUploadedFile = (uploadResultArr) => {
            let str = [];
            $(uploadResultArr).each(function(i, obj){
                if(!obj.image){
                    let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uploadPath + "/s_"+obj.uuid+"_"+obj.fileName);
                    //str.push("<li><a href='/download?fileName="+ fileCallPath +"'>" + "<img src='/resoureces/img/attach.png'>"+obj.fileName+"</a></li>");
                    str.push("<li><img src='/resources/img/attach.png'>"+obj.fileName+"</li>");
                } else {
                    // str.push("<li>" + obj.fileName + "</li>");
                    console.log(obj);
                    let fileCallPath = encodeURIComponent(
                        obj.uploadPath + "/s_"+obj.uuid+"_"+obj.fileName
                    );
                    str.push("<li> <img src='/display?fileName="+fileCallPath+"'></li>");

                }
            });
            uploadResult.append(str);
        }

        $("#uploadBtn").on("click", function(e){
            let formData = new FormData();
            let inputFile = $("input[name='uploadFile']");
            let files = inputFile[0].files;

            for(let i = 0; i < files.length; i++){
                console.log(files[i])
                if(!checkExtension(files[i].name,files[i].size)) return false;

                formData.append("uploadFile", files[i]);
                console.log(formData);
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
                    showUploadedFile(result)
                    $('.uploadDiv').html(cloneObj.html());
                },
                fail : function(e){
                    alert(e);
                }
            });
        })

    })
</script>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>uploadAjax</h1>
    <div class="custom-file uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>
    <div class="fa-upload uploadResult">
        <ul>

        </ul>
    </div>
    <button id="uploadBtn">Upload</button>
</body>
</html>

