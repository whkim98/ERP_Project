package com.erplab.repository;

import com.lec.spring.domain.Comment;

import java.util.List;

public interface CommentRepository {

    //특정 글(write_id)의 댓글 목록
    List<Comment> findByWrite(Long write_id);
    //댓글 작성
    int save(Comment comment);

    int deleteById(Long id);
}
