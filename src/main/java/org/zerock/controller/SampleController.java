package org.zerock.controller;


import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.SampleDTO;

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

}
