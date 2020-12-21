package org.zerock.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;
import java.util.stream.IntStream;

@Log4j
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@RunWith(SpringJUnit4ClassRunner.class)
public class ReplyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Test
    public void testMapper(){
        log.info("=======Mapper  ==========");
        log.info(mapper);
    }

    private Long[] bnoArr = {2275L,2274L,2273L,2272L,2271L };
    @Test
    public void testCreate(){

        IntStream.rangeClosed(1,10).forEach( i ->{
            ReplyVO vo = new ReplyVO();
            vo.setBno(bnoArr[i%5]);
            vo.setReply("댓글 테스트 " + i);
            vo.setReplyer("카카오 경력자 "+ i);

            mapper.insert(vo);
        });
    }

    @Test
    public void testRead(){
        Long tagetBno = 5L;
        ReplyVO vo = mapper.read(tagetBno);
        log.info(vo);
    }

    @Test
    public void testDelete(){
        Long targetRno = 3L;
        mapper.delete(targetRno);
    }

    @Test
    public void testUpdate(){
        Long targetRno = 10L;
        ReplyVO vo = mapper.read(targetRno);
        vo.setReply("Update Reply");
        int count = mapper.update(vo);
        log.info("Update " + count);
    }

    @Test
    public void testList(){
        Criteria cri = new Criteria(2,10);
        List<ReplyVO> replies = mapper.getListWithPaging(cri,45000L);
        replies.forEach(reply -> log.info(reply));
    }
}
