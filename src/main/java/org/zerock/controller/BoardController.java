package org.zerock.controller;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PagingDTO;
import org.zerock.service.BoardService;

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
        log.info("register" + board.toString());
        if(board.getAttachList() != null) board.getAttachList().forEach(attach -> log.info(attach));
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
        if(service.remove(bno)){
            rttr.addFlashAttribute("result","success");
        }
        rttr.addAttribute("amount",cri.getAmount());
        rttr.addAttribute("pageNum",cri.getPageNum());
        rttr.addAttribute("keyword", cri.getKeyword());
        rttr.addAttribute("type",cri.getType());
        return "redirect:/board/list";

    }

}
