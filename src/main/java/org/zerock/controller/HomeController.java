package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Locale;

@Controller
@Log4j
@RequestMapping("/home/*")
public class HomeController {

//    @RequestMapping(value = "/", method = RequestMethod.GET)
//    public String home(Locale locale, Model model){
//        log.info("welcome home, the client locale is {}.", locale);
//    }

}
