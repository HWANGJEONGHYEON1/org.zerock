package org.zerock.domain;

import lombok.Data;

@Data
public class AttaachFileDTO {
    private String fileName;
    private String uploadPth;
    private String uuid;
    private boolean image;


}
