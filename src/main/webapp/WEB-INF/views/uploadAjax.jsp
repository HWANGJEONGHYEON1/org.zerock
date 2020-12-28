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

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255,255,255,0.5);
    }

    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img{
        width:600px
    }
</style>
<script type="text/javascript">

    let showImage = (fileCallPath) => {
        $(".bigPictureWrapper").css("display","flex").show();

        $(".bigPicture")
        .html("<img src='/display?fileName=" +encodeURI(fileCallPath)+"'>")
        .animate({width:'100%', height: '100%'}, 1000);
    }

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
                    let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
                    originPath = originPath.replace(new RegExp(/\\/g), "/");

                    str.push("<li>" +
                        "<a href=\"javascript:showImage(\'"+originPath+"\')\">" +
                        "<img src='/display?fileName="+fileCallPath+"'>" +
                        "<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span>" +
                        "</a>" +
                        "</li>");

                }
            });
            uploadResult.append(str);
        }

        $(".uploadResult").on("click", "span", function (e){
            let targetFile = $(this).data("file");
            let type = $(this).data("type");
            console.log(targetFile);

            $.ajax({
                url: '/deleteFile',
                data: {fileName: targetFile, type: type},
                dataType: 'text',
                type: 'POST',
                success: function(result) {
                    alert(result);
                }
            });
        });

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
        });

        $(".bigPictureWrapper").on("click", function (e){
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
            setTimeout(function(){
                $('.bigPictureWrapper').hide()
            },1000);
        });
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

    <div class="bigPictureWrapper">
        <div class="bigPicture"></div>
    </div>
</body>
</html>

