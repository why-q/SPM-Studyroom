package com.mango.service;


import com.mango.pojo.BlackList;
import com.mango.pojo.Student;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public interface BlackListService {
    List<Student> getAllBlackedStudent();
    void addStudentBlackList(BlackList blackList);

    BlackList getBlackedStudentById(String s_id);
    void deleteStudentBlackList(String s_id);
}
