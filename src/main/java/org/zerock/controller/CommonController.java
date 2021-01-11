package org.zerock.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Log4j
public class CommonController {

    @GetMapping("/accessError")
    public void accessDenied(Authentication auth, Model model){
        log.info("access denied == " + auth);
        model.addAttribute("msg", "Access denied");
    }

    @GetMapping("/customLogin")
    public void loginInput(String err, String logout, Model model){
        log.info("err : " + err);
        log.info("logout: " + logout);

        if(err != null)
            model.addAttribute("error", "LoginError check your account");

        if(logout != null) {
            model.addAttribute("logout" , "Logout!");
        }
    }

    @GetMapping("/customLogout")
    public void logoutGET() {
        log.info("# custom Logout");
    }

}
