package org.zerock.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j
public class CustomLoginSuccesshandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {
        log.warn("login success");

        List<String> roleNames = new ArrayList<>();

        auth.getAuthorities().forEach(authority -> {
            roleNames.add(authority.getAuthority());
        });

        log.warn("Role names : " +roleNames);

        if(roleNames.contains("ROLE_USER")){
            response.sendRedirect("/sample/all");
            return;
        }

        if(roleNames.contains("ROLE_MEMBER")){
            log.info("# roleMember " );
            response.sendRedirect("/sample/member");
            return;
        }

        if(roleNames.contains("ROLE_ADMIN")){
            log.info("## " + roleNames);
            response.sendRedirect("/sample/admin");
            return;
        }


        response.sendRedirect("/");
    }
}
