package com.erplab.service;

import com.lec.spring.domain.FileDTO;
import com.lec.spring.repository.FileRepository;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileService {
    private FileRepository fileRepository;

    @Autowired
    public FileService(SqlSession sqlSession){
        fileRepository = sqlSession.getMapper(FileRepository.class);
        System.out.println("FileService() 생성");
    }

    public FileDTO findById(Long id){
        return fileRepository.findById(id);
    }
    // 나머지 method는 글 쪽에서 수정해야 한다.
}
