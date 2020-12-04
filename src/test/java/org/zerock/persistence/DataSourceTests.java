package org.zerock.persistence;

import static org.junit.Assert.fail;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.config.RootConfig;

import javax.sql.DataSource;
import java.sql.Connection;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class DataSourceTests {
    @Setter(onMethod_ = { @Autowired })
    private DataSource dataSource;
    @Test
    public void testConnection() {
        try (Connection con = dataSource.getConnection()){
            log.info(con);
        }catch (Exception e){
            fail(e.getMessage());
        }
    }

    @Setter(onMethod_ = { @Autowired})
    private SqlSessionFactory sqlSessionFactory;

    @Test
    public void testMyBatis() {
        try (SqlSession session = sqlSessionFactory.openSession();
             Connection con = session.getConnection();
        ){
            log.info(session);
            log.info(con);
        }catch (Exception e){
            e.getMessage();
        }
    }

}
