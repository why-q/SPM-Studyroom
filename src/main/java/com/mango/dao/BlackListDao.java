package com.mango.dao;


import com.mango.pojo.BlackList;
import com.mango.pojo.Student;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BlackListDao {
    List<Student> getAllBlackedStudent();
    
    BlackList getBlackedStudentById(String s_id);
    void deleteStudentBlackList(String s_id);
    void addStudentBlackList(BlackList blackList);
}
