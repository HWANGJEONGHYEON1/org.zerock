package org.zerock.controller;


import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Log4j
public class SampleController {

    @GetMapping("/doA")
    public void doA(){
        System.out.println("굿굿");
        log.info("#### $$$$$ @@@2");
        log.info("doA ... 실행");
    }
}
