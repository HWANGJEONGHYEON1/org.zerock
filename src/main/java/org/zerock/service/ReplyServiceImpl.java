package org.zerock.service;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

//    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO vo) {

        log.info("Relply Service ==== Register : " +vo );
        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long rno) {
        log.info("Relply Service ==== get : " + rno);
        return mapper.read(rno);
    }

    @Override
    public int modify(ReplyVO vo) {
        log.info("Relply Service ==== modify : " +vo );
        return mapper.update(vo);
    }

    @Override
    public int remove(Long rno) {
        log.info("Relply Service ==== remove : " + rno );
        return mapper.delete(rno);
    }

    @Override
    public List<ReplyVO> getList(Criteria cri, Long bno) {
        log.info("Relply Service ==== List<ReplyVo) : " + bno );
        return mapper.getListWithPaging(cri,bno);
    }
}