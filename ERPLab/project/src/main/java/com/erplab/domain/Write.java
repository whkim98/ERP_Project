package com.erplab.domain;

import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

// Model 객체 (domain, DTO: Data Transfer Object)

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Write {
    private Long id;    // 글 id (PK)
    private String subject;
    private String content;
    private LocalDateTime regDate;
    private long viewCnt;

    private User user;   // 글 작성자 (FK)

    // 첨부파일, 댓글
    @ToString.Exclude
    @Builder.Default   // 아래와 같이 초깃값 있으면 @Builder.Default 처리 (builder 제공 안함)
//    @Getter(AccessLevel.NONE)
//    @Setter(AccessLevel.NONE)
    private List<FileDTO> fileList = new ArrayList<>();

}












