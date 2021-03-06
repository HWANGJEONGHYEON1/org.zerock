package org.zerock.controller;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PagingDTO;
import org.zerock.service.BoardService;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor

public class BoardController {
    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria cri,Model model){
        log.info("list...."+cri );
        int total = service.getTotalCount(cri);
        log.info(total);
        model.addAttribute("list",service.getList(cri));
        model.addAttribute("pageMaker", new PagingDTO(cri, total));
    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr){
        log.info("register Contorller = " + board);

        if(board.getAttachList() != null) board.getAttachList().forEach(attach -> log.info(attach));
        log.info("=========");
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }
    @GetMapping("/register")
    public void register(){

    }

    @GetMapping({"/get","/modify"})
    public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri){
        log.info("/get or modify");
        log.info(cri);
        model.addAttribute("board", service.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("modify");

        if (service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("amount",cri.getAmount());
        rttr.addAttribute("pageNum",cri.getPageNum());
        rttr.addAttribute("keyword", cri.getKeyword());
        rttr.addAttribute("type",cri.getType());

        return "redirect:/board/list" ;
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr){
        log.info(".......remove");
        List<BoardAttachVO> attachList = service.getAttachList(bno);

        if(service.remove(bno)){
            deleteFiles(attachList);
            rttr.addFlashAttribute("result","success");
        }

        return "redirect:/board/list" + cri.getListLink();
    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
        log.info("# Controller " + bno);
        return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
    }

    private void deleteFiles(List<BoardAttachVO> attachList) {
        if(attachList == null || attachList.size() == 0) return ;

        log.info("Controller delete attach List ");
        log.info(attachList);

        String filePath = "/Users/hwangjeonghyeon/IdeaProjects/upload/";
        attachList.forEach(attach -> {
            try{
                //static final String uploadFolder = "/Users/hwangjeonghyeon/IdeaProjects/upload/";
                Path file = Paths.get("/Users/hwangjeonghyeon/IdeaProjects/upload/" + attach.getUploadPath() + "/" +
                        attach.getUuid() + "_" + attach.getFileName());

                Files.deleteIfExists(file);

                if(Files.probeContentType(file).startsWith("image")) {
                    Path thumbNail = Paths.get(filePath+attach.getUploadPath()+"\\s_" + attach.getUuid() + "_" + attach.getFileName() );
                    Files.delete(thumbNail);

                }
            } catch(Exception e) {
                log.error("delete file error " + e.getMessage());
            }
        });
    }

}
