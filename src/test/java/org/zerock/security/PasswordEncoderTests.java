package org.zerock.security;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@Log4j
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class, org.zerock.config.SecurityConfig.class})
public class PasswordEncoderTests {

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder pwEncoder;

    @Test
    public void testEncode(){
        String str = "member";
        String enStr = pwEncoder.encode(str);

        log.info(enStr);
    }
}
