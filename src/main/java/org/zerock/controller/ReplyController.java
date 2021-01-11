package org.zerock.controller;

import jdk.nashorn.internal.objects.annotations.Getter;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;


@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
    private ReplyService service;

    @PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE}) // JSON 방식으로 데이터 처리, produces 문자열을 반환하도록 
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
        log.info("Controller => ReplyVO " + vo);
        int insertCount = service.register(vo);

        log.info("Controller => insert count " + insertCount );
        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

//    @GetMapping(value = "/pages/{bno}/{page}" , produces = {MediaType.APPLICATION_XML_VALUE,
//                                                           MediaType.APPLICATION_JSON_UTF8_VALUE })
//    public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
//        log.info("Controller => getList");
//        Criteria cri = new Criteria();
//        log.info(cri);
//        return new ResponseEntity<>(service.getList(cri,bno), HttpStatus.OK);
//    }

    @GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE,
                                              MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
        log.info("Controller => get " + rno);
        return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
    }

    @DeleteMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE,
            MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
        log.info("Controller remove => : " + rno);
        return service.remove(rno) == 1 ?
                new ResponseEntity<>("success" , HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @RequestMapping( method = {RequestMethod.PUT , RequestMethod.PATCH},
            consumes = "application/json",
            value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE}
    )
    public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
        log.info("Controller update " + rno);
        vo.setRno(rno);
        log.info("modify =>" + vo);
        return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){

        Criteria cri = new Criteria(page,10);
        log.info("controller => list bno" + bno);
        log.info("cri: "+ cri);

        return new ResponseEntity<>(service.getListPage(cri,bno), HttpStatus.OK);
    }
}
