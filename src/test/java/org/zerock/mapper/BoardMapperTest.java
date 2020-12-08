package org.zerock.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardMapperTest {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper  mapper;

    @Test
    public void test(){
        mapper.getList().forEach(board -> log.info(board.toString()));
    }

    @Test
    public void testInsert() {
        BoardVO board = new BoardVO();
        board.setTitle("new Title");
        board.setContent("new Content");
        board.setWriter("new Writer");

        mapper.insertSelectKey(board);
        log.info(board);
    }

    @Test
    public void readTest(){
        BoardVO vo = mapper.read(5L);
        log.info(vo);
    }

    @Test
    public void deleteTest(){
        log.info("=================" );
        log.info(mapper.delete(3L));
    }

    @Test
    public void updateTest(){
        BoardVO vo = new BoardVO();
        vo.setWriter("수정된 작성자");
        vo.setContent("수정 된 내용 !!!!!!");
        vo.setTitle("수정된 제목");
        vo.setBno(5L);

        int count = mapper.update(vo);
        log.info("#### " + count);
    }


}