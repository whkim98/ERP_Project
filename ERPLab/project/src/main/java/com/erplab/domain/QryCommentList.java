package com.erplab.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class QryCommentList extends QryResult {

    @JsonProperty("data")       //Json 변환시 "data"란 이름의 property로 변환됨
    List<Comment> list;
}
