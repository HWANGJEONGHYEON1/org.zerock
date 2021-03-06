package org.zerock.controller;

import com.google.gson.Gson;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.BoardVO;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class, org.zerock.config.ServletConfig.class})
@Log4j
public class BoardControllerTest {

    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext ctx;

    private MockMvc mockMvc;

    @Before
    public void setup(){
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void testList() throws Exception{
        log.info(
                mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
                .andReturn()
                .getModelAndView()
                .getModelMap()
        );
    }

    @Test
    public void testListPaging() throws Exception{
        log.info(mockMvc.perform(
            MockMvcRequestBuilders.get("/board/list")
            .param("pageNum","2")
            .param("amount","50"))
            .andReturn().getModelAndView().getModelMap()
        );
    }

    @Test
    public void testRegister() throws Exception{
        String reusltPage = mockMvc.perform(post("/board/register")
                .param("title","new title")
                .param("content","new Content")
                .param("writer", "user01")
        ).andReturn().getModelAndView().getViewName();

        log.info(reusltPage);
    }

    @Test
    public void testGet() throws Exception{
        log.info(mockMvc.perform(
                MockMvcRequestBuilders.get("/board/get")
                .param("bno","2")
        ).andReturn().getModelAndView().getModelMap());
    }

    @Test
    public void testModify() throws Exception{
        String resultPgae = mockMvc.perform(post("/board/modify")
        .param("bno", "1")
        .param("title","수정된 새글")
        .param("content", "수정된 내용")
        .param("writer", "user000")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPgae);
    }

    @Test
    public void testRemove() throws Exception{
        String resultPgae = mockMvc.perform(post("/board/remove")
                .param("bno", "4")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPgae);
    }

    @Test
    public void testConvert() throws Exception {
        BoardVO vo = new BoardVO();
        vo.setWriter("카카오개발자");
        vo.setTitle("REST API 란");
        vo.setContent("~~~~~~~");
        String jsonStr = new Gson().toJson(vo);
        mockMvc.perform(post("/post/ticket").contentType(MediaType.APPLICATION_JSON).content(jsonStr))
                .andExpect(status().is(200));
    }
}

