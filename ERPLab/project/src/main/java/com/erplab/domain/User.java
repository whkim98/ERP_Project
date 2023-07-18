package com.erplab.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private long id;
    private String username;   //회원 아이디
    @JsonIgnore //자바 객체가 json으로 변환할때 getter/setter로 변환되는데, 변환을 안시키는 @어노테이션이다.
    private String password;    //회원 비밀번호
    @ToString.Exclude
    @JsonIgnore
    private String re_password; //비밀번호 확인 입력
    private String name;    //회원 이름
    @JsonIgnore
    private LocalDateTime regDate;

    @ToString.Exclude       //toString()함수 사용될때 해당 @TString.Exclude로 제외시킴
    @Builder.Default        //builder로 build할땐 default값으로 남아있게 함
    @JsonIgnore
    private List<Authority> authorities = new ArrayList<>();

    //가변 매개변수 : Authority가 몇개든 받는다. 변수인 authorities는 배열이다.
    public void addAuthority(Authority... authorities){
        if(authorities != null){
            Collections.addAll(this.authorities, authorities);
        }
    }

}
