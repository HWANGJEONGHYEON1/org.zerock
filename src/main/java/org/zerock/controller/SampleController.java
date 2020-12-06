package org.zerock.controller;


import lombok.extern.log4j.Log4j;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {

    @RequestMapping("")
    public void basic(){
        log.debug("#### $$$$$ @@@");
        log.info("bbasic.............");
    }

    @RequestMapping(value="/basic", method = {RequestMethod.GET,RequestMethod.POST})
    public void basicGet(){
        log.info("basic get...");
    }

    @GetMapping("/basicOnlyGet")
    public void basicGet2(){
        log.info("basic get only .....");
    }

    @GetMapping("/ex01")
    public String ex01(SampleDTO dto){
        log.info("#" + dto);
        return "ex01";
    }

    @GetMapping("/ex02")
    public String ex02(@RequestParam("name") String name, @RequestParam("age") int age){
        log.info(name);
        log.info(age);
        return "ex02";
    }

    @GetMapping("/ex02List")
    public String ex02List(@RequestParam("ids") String[] ids){
        log.info(ids.toString());
        return "ex02List";
    }

    @GetMapping("/ex02Bean")
    public String ex02Bean(SampleDTOList list){
        log.info(list);
        return "ex02Bean";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-mm-dd");
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sd, false));
    }

    @GetMapping("/ex03")
    public String ex03(TodoDTO dto){
        log.info("todo" + dto);
        return "ex03";
    }

    @GetMapping("/ex04")
    public String ex04(SampleDTO dto, int page){
        log.info("dto " + dto);
        log.info("page " + page);
        return "/sample/ex04";
    }

    @GetMapping("/ex05")
    public String ex05(SampleDTO dto, @ModelAttribute("page") int page){
        log.info("dto " + dto);
        log.info("page " + page);
        return "/sample/ex04";
    }

    @GetMapping("/ex06")
    public @ResponseBody SampleDTO ex06(){
        log.info("/ex..........06");
        SampleDTO dto = new SampleDTO();
        dto.setAge(10);
        dto.setName("홍길동");
        return dto;
    }

    @GetMapping("/exUpload")
    public String exUpload(){
        log.info("../upload");
        return "/sample/exUpload";
    }

    @PostMapping("/exUploadPost")
    public void exUploadPost(ArrayList<MultipartFile> files){
        files.forEach(file -> {
            log.info("-------------------");
            log.info("name -> " + file.getOriginalFilename());
            log.info("size -> " + file.getSize() );
        });
    }
}
