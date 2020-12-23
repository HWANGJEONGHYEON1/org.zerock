package org.zerock.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Log4j
@Component
public class LogAdvice {

    @Before("execution(* org.zerock.service.AopSampleService*.doAdd(String,String)) && args(str1,str2) ")
    public void logBeforeWithParam(String str1, String str2){
        log.info("=====================");
        log.info("str1 "+ str1);
        log.info("str2 "+ str2);
    }

    @AfterThrowing(pointcut = "execution(* org.zerock.service.AopSampleService*.*(..))", throwing = "ex")
    public void logException(Exception ex){

        log.info("Exception !");
        log.info("Exception : " + ex);
    }

    @Around("execution( * org.zerock.service.AopSampleService*.*(..))")
    public Object logTime(ProceedingJoinPoint pjp){
        long start = System.currentTimeMillis();

        log.info("target : " + pjp.getTarget());
        log.info("param : " + Arrays.toString(pjp.getArgs()));

        Object result = null;
        try{
            result = pjp.proceed();
        } catch (Throwable e){
            e.printStackTrace();
        }

        long end = System.currentTimeMillis();
        log.info("Time : " + (end - start));
        return result;
    }
}
