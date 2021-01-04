package org.zerock.task;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Log4j
@Component
public class FileCheckTask {

    @Setter(onMethod_ = { @Autowired })
    private BoardAttachMapper mapper;

    private String getFolderYesterDay() {
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-mm-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);

        String str = sd.format(cal.getTime());
        return str.replace("-", File.separator);
    }

    @Scheduled(cron="0 0 2 * * *")
    public void checkFiles() throws Exception{
        log.warn("#File chekc Task run....");
        log.warn("==================");

        List<BoardAttachVO> fileList = mapper.getOldFiles();

        List<Path> fileListPaths = fileList.stream().map(
                vo -> Paths.get("/Users/hwangjeonghyeon/IdeaProjects/upload/",
                        vo.getUploadPath(),
                        "_s" + vo.getUuid() + "_" +vo.getFileName())).collect(Collectors.toList());

        fileList.stream().filter( vo -> vo.isFileType() == true)
                .map( vo -> Paths.get("/Users/hwangjeonghyeon/IdeaProjects/upload/",
                        vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));

        log.warn("======================");

        fileListPaths.forEach(p -> log.warn(p));

        File targetDir = Paths.get("/Users/hwangjeonghyeon/IdeaProjects/upload/", getFolderYesterDay()).toFile();

        File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

        log.warn("----------------------------");
        for(File file : removeFiles) {
            log.warn(file.getAbsolutePath());
            file.delete();
        }

    }
}
