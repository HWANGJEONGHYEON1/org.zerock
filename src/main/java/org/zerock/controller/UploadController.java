package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.apache.maven.model.Model;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttaachFileDTO;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@Log4j
public class UploadController {
    static final String uploadFolder = "/Users/hwangjeonghyeon/IdeaProjects/upload/";
    @GetMapping("/uploadForm")
    public void uploadForm(){
        log.info("upload form");

    }

    @GetMapping("/uploadAjax")
    public void uploadAjax(){
        log.info("# uplaod Ajax");
    }

    @PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttaachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
        log.info("update ajax post");
        List<AttaachFileDTO> list = new ArrayList<>();
        File uploadPath = new File(uploadFolder,getFolder());
        log.info("# getFolder() " +getFolder());

        if(!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        for(MultipartFile multipartFile : uploadFile){
            AttaachFileDTO attaachFileDTO = new AttaachFileDTO();
            log.info("==========");
            String uploadFileName =  multipartFile.getOriginalFilename();
            attaachFileDTO.setFileName(uploadFileName);

            log.info("UploadFiie Name "+ uploadFileName);
            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try{
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);
                attaachFileDTO.setUuid(uuid.toString());
                attaachFileDTO.setUploadPath(getFolder());
                log.info("## UploadPath " + uploadPath);
                log.info(uploadFileName);
                if(checkImageType(saveFile)){
                    attaachFileDTO.setImage(true);
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_" + uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100,100);
                    thumbnail.close();
                }
                list.add(attaachFileDTO);
            } catch(Exception e ){
                log.error(e);
            }
        }

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    private String getFolder() {
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sd.format(date);
        return str.replace("-", File.separator);
    }

    private boolean checkImageType(File file){
        try{
            String contentType = Files.probeContentType(file.toPath());
            return contentType.startsWith("image");
        } catch (Exception e){
            log.error(e);
        }

        return false;
    }

    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName){
        log.info("file name" + fileName);
        File file = new File(uploadFolder + fileName);
        log.info(file);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.add("Content-type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),httpHeaders,HttpStatus.OK);
        } catch (Exception e){
            log.error(e);
            e.printStackTrace();
        }
        return result;
    }

    @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<org.springframework.core.io.Resource> downloadFile(String fileName){
        log.info("downLoad : " + fileName);
        Resource resource = new FileSystemResource(uploadFolder+fileName);
        log.info("resource : " + resource);
        String resourceName = resource.getFilename();
        log.info("resourceName " + resourceName);
        HttpHeaders headers = new HttpHeaders();
        try {
            headers.add("Content-Disposition",
                    "attachment; filename=" + new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
        } catch (UnsupportedEncodingException e){
            e.printStackTrace();
        }

        return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }
}
