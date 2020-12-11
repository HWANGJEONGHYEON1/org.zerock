package org.zerock.service;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardServiceTest {

    @Setter(onMethod_ = {@Autowired})
    private BoardService service;

    @Test
    public void exsistTest(){
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testGetList(){
        service.getList(new Criteria(2,10)).forEach(board->log.info(board));
    }

    @Test
    public void testRegister(){
        BoardVO board = new BoardVO();
        board.setTitle("Service 생성 후 새로 작성 타이틀");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newbie");

        service.register(board);
        log.info("## 생선된 게시물의 번호 : " + board.getBno());
    }

//    @Test
//    public void testAllList(){
//        BoardVO board = new BoardVO();
//        service.getList().forEach(v -> log.info(v.toString()));
//    }

    @Test
    public void removeTest(){
        log.info("# remove" + service.remove(2L));
    }
}
