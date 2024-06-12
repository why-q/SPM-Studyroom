package com.mango;

import com.mango.dao.*;
import com.mango.pojo.*;
import com.mango.service.BlackListService;
import com.mango.service.ClassroomService;
import com.mango.service.ReservationService;
import com.mango.service.StudentService;
import com.mango.utils.CommonUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class ReserveDemoApplicationTests {

    @Autowired
    DataSource dataSource;

    @Autowired
    StudentDao studentDao;

    @Autowired
    ReservationDao reservationDao;

    @Autowired
    ClassroomDao classroomDao;

    @Autowired
    BaseDao baseDao;

    @Autowired
    BlackListDao blackListDao;

    @Autowired
    BlackListService blackListService;

    @Autowired
    StudentService studentService;

    @Autowired
    ReservationService reservationService;

    @Autowired
    ClassroomService classroomService;

//    @Test
//    @Transactional  // 确保每个测试方法在执行完毕后进行回滚，避免测试数据污染
//    public void testSearchStudentExistsInDatabase() {
//        // 假设的学生信息
//        String studentId = "32005048";
//        String studentName = "Test Student";
//
//        // 创建并保存测试学生
//        Student testStudent = new Student();
//        testStudent.setS_id(studentId);
//        testStudent.setS_name(studentName);
//        testStudent.setS_class("Test Class");
//        testStudent.setS_year("1");
//        testStudent.setS_major("Test Major");
//        testStudent.setS_phone_number("123456789");
//
//        // 检查数据库中是否已存在该学生
//        Student existingStudent = studentService.getStudentById(studentId);
//        if (existingStudent == null) {
//            // 如果学生不存在，则添加学生到数据库
//            studentService.addStudent(testStudent);
//        }
//
//        // 执行搜索
//        List<Student> foundStudents = studentService.searchStudentsByNameOrId(studentId);
//        assertNotNull(foundStudents, "Search should return a result");
//        assertFalse(foundStudents.isEmpty(), "Search should not be empty");
//        assertTrue(foundStudents.stream().anyMatch(s -> s.getS_id().equals(studentId)), "Should find the test student by ID");
//
//        // 清理测试数据
//        studentService.deleteStudentInfo(studentId);
//    }

    @Test
    @Transactional
    public void testSearchStudentExistsInDatabase() {
        // 测试学生数据
        String studentId = "32005048";
        String studentName = "Test Student";

        // 创建并保存测试学生
        Student testStudent = new Student();
        testStudent.setS_id(studentId);
        testStudent.setS_name(studentName);
        testStudent.setS_class("Test Class");
        testStudent.setS_year("1");
        testStudent.setS_major("Test Major");
        testStudent.setS_phone_number("123456789");

        // 检查数据库中是否已存在该学生
        Student existingStudent = studentService.getStudentById(studentId);
        if (existingStudent == null) {
            // 如果student不存在，则将student添加到数据库
            studentService.addStudent(testStudent);
        }

        // 获取所有学生并搜索测试学生
        List<Student> allStudents = studentService.getAll();
        List<Student> foundStudents = allStudents.stream()
                .filter(s -> s.getS_id().equals(studentId) || s.getS_name().equals(studentName))
                .collect(Collectors.toList());

        assertNotNull(foundStudents, "Search should return a result");
        assertFalse(foundStudents.isEmpty(), "Search should not be empty");
        assertTrue(foundStudents.stream().anyMatch(s -> s.getS_id().equals(studentId)), "Should find the test student by ID");

        // 如果不使用@Transactional，可以选择清理测试数据
        if (existingStudent == null) {
            studentService.deleteStudentInfo(studentId);
        }
    }

    @Test
    void contextLoads() throws SQLException {
        Student student = new Student();
        student.setS_id("32001041");
        List<Student> info = reservationDao.getAllStudentReservationInfo(student);
        System.out.println(info.size());
        for (Student s : info) {
            System.out.println(s);
        }
    }

    @Test
    @Transactional
    public void testDeleteExistingClassroom() {
        // 添加一个测试用的教室，以确保有可删除的数据
        Classroom testClassroom = new Classroom(
                "testRoom101",
                "Test Classroom",
                "testBuilding01",
                "1",
                "100",
                "yes"
        );
        classroomDao.addClassroom(testClassroom);

        // 验证教室是否已添加
        assertFalse(
                classroomDao.getAll().stream().anyMatch(
                        classroom -> classroom.getRoom_id().equals("testRoom101")
                ),
                "Classroom should exist before deletion"
        );

        // 执行测试教室删除操作
        classroomService.deleteClassroomInfo("testRoom101");

        // 验证教室是否已被正确删除
        assertFalse(
                classroomDao.getAll().stream().anyMatch(
                        classroom -> classroom.getRoom_id().equals("testRoom101")
                ),
                "Classroom should be deleted"
        );
    }

    @Test
    public void testStudent() {
        List<Student> all = studentDao.getAll();

        for (Student student : all) {
            System.out.println(student);
        }
    }

    @Test
    public void testTime() throws ParseException {

        System.out.println(CommonUtil.toUseRate("1","89"));

    }

    @Test
    public void testClassroom() {
        Map<String, Object> map = new HashMap<>();
        List<Classroom> allReservationInfo = reservationDao.getAllClassroomReservationInfo(map);
        System.out.println(allReservationInfo.size());
        for (Classroom classroom : allReservationInfo) {
            System.out.println(classroom);
        }
    }

    @Test
    public void testAllClassroom() {
        //获取所有教室的基本信息并打印
        List<Classroom> all = classroomDao.getAll();
        for (Classroom classroom : all) {
            System.out.println(classroom);
        }
        //获所有教室的学生预约信息
        Map<String, Object> map = new HashMap<>();
        List<Classroom> allReservationInfo = reservationDao.getAllClassroomReservationInfo(map);
        System.out.println(allReservationInfo.size());
        for (Classroom classroom : allReservationInfo) {
            System.out.println(classroom);
        }
    }

    @Test
    public void testUpdateClassroomInfo() {
        //修改教室信息，比如classroom_id
        Map<String, Object> map = new HashMap<>();
        map.put("room_id", "101");
        map.put("available_seat", "100");

        classroomDao.updateClassroom(map);

    }


    @Test
    public void testConstantData() {
        System.out.println(baseDao.countStudent());
        System.out.println(baseDao.countClassroom());
        System.out.println(baseDao.countReservation());
    }

    @Test
    public void testUpdateStudentInfo() {
        Student student = new Student();
        student.setS_id("32001033");
        student.setS_year("1");
        studentDao.updateStudentInfo(student);
    }

    @Test
    public void testCountStudentReservation() {
        List<Student> students = studentDao.countStudentReservation();
        for (Student student : students) {
            System.out.println(student);
        }
    }

    @Test
    public void testCountReservation() {
        Map<String, Object> map = new HashMap<>();
        map.put("s_id", "32009081");
//        map.put("state","预约取消");
        int i = studentDao.countReservation(map);
        System.out.println(i);
    }

    @Test
    public void testAllAvailableClassroom() {
        Map<String, Object> map = new HashMap<>();
//        Map<String, Map<String, String>> room_id_and_time_id = new HashMap<>();
//        room_id_and_time_id.put("2014", new HashMap<>() {{
//            put("201", "4");
//        }});
//        room_id_and_time_id.put("2015", new HashMap<>() {{
//            put("201", "5");
//        }});
//
//
//        map.put("room_id_and_time_id", room_id_and_time_id);
//        map.put("room_id","11");
        map.put("time_begin", "07:00:00");
        map.put("time_end", "08:00:00");
        List<Classroom> allAvailableClassrooms = reservationDao.getAllAvailableClassroom(map);
        System.out.println(allAvailableClassrooms.size());
        for (Classroom allAvailableClassroom : allAvailableClassrooms) {
            System.out.println(allAvailableClassroom);
        }
    }

    @Test
    @Transactional
    public void testAdd() throws ParseException {
        Student testStudent = new Student("33", "Test Name", "Test Class", "Test Year", "Test Major", "123456789");
        studentDao.addStudent(testStudent); // 假设这个方法已经实现，可以添加学生

        StudentReservation studentReservation = new StudentReservation("33", "33", "33", "33", "2001-01-06", "33", "33");
        studentDao.addStudentReservation(studentReservation);
    }

    @Test
    void testUpdate() {
        RoomAvailableTimeInfo roomAvailableTimeInfo = new RoomAvailableTimeInfo();
        roomAvailableTimeInfo.setTime_id("1");
        roomAvailableTimeInfo.setRoom_id("101");
        roomAvailableTimeInfo.setBuilding_id("1");
        roomAvailableTimeInfo.setAvailable_date("2001-01-07");
        classroomDao.updateDeleteRoomAvailableSeatInfo(roomAvailableTimeInfo);


    }

    @Test
    public void testBlack() {
        for (Student student : blackListDao.getAllBlackedStudent()) {
            System.out.println(student);
        }

    }

    @Test
    //获取学生ID为" "的学生所有取消预约的日期，并检查是否有连续7天内有三次取消记录。
    public void testRe() {
        List<String> info = reservationDao.getAllCanceledReservationDateById("32001033");
        for (int i = 0; i < info.size(); i++) {
            int date1 = Integer.parseInt(info.get(i));
            for (int j = i + 1; j < info.size(); j++) {
                int date2 = Integer.parseInt(info.get(j));
                if (Math.abs(date1 - date2) <= 7) {
                    for (int k = j + 1; k < info.size(); k++) {
                        int date3 = Integer.parseInt(info.get(k));
                        if (Math.abs(date2 - date3) <= 7) {
                            System.out.println("yep");
                            return ;
                        }
                    }
                }
            }
        }
        System.out.println("nope");
    }

    @Test
    public void testAddStudentToBlackList(){
        String studentId = "32005048";
        String reason = "违反预约规则";

        Student testStudent = new Student();
        testStudent.setS_id(studentId);
        testStudent.setS_name("Test Student");
        testStudent.setS_class("Test Class");
        testStudent.setS_year("1");
        testStudent.setS_major("Test Major");
        testStudent.setS_phone_number("123456789");

        //检查数据库中是否已存在该学生
        Student existingStudent = studentDao.getStudentById(studentId);
        if (existingStudent == null) {
            // 如果学生不存在，则添加学生到数据库
            studentDao.addStudent(testStudent);
        } else {
            // 如果学生已存在，直接进入下一步
            fail("Student already exists in the database.");
        }
        // 将学生添加到黑名单
        BlackList blackList = new BlackList();
        blackList.setS_id(studentId);
        blackList.setState(reason);
        blackListService.addStudentBlackList(blackList);
        // 验证学生是否已被正确添加到黑名单
        BlackList blacklistedStudent = blackListService.getBlackedStudentById(studentId);
        assertNotNull(blacklistedStudent, "Student should be added to the blacklist");
        assertEquals(studentId, blacklistedStudent.getS_id(), "Blacklisted student ID should match");
        assertEquals(reason, blacklistedStudent.getState(), "Blacklisted reason should match");
        // 清理环境: 删除黑名单和学生信息
        blackListService.deleteStudentBlackList(studentId);
        studentDao.deleteStudentById(studentId);
    }

    @Test
    @Transactional
    public void testDeleteStudentAccount() {
        // 准备测试数据
        String studentId = "32005048";
        Student testStudent = new Student(studentId, "Delete Test", "Test Class", "1", "Test Major", "123456789");
        studentService.addStudent(testStudent);

        // 验证学生已添加
        Student addedStudent = studentDao.getStudentById(studentId);
        assertNotNull(addedStudent, "Student should be added before deletion");

        // 模拟添加预约记录和黑名单记录
        StudentReservation reservation = new StudentReservation(studentId, "1", "1", "1", "2023-06-11", "Test Room", "Test State");

        // 验证预约记录已添加
        List<Student> reservations = reservationDao.getAllStudentReservationInfo(testStudent);
        assertTrue(reservations.isEmpty(), "Reservation should be added before deletion");

        // 删除学生账户
        studentService.deleteStudentInfo(studentId);

        // 验证学生已删除
        Student deletedStudent = studentDao.getStudentById(studentId);
        assertNull(deletedStudent, "Student should be deleted");

        // 验证相关黑名单记录已删除
        BlackList blacklistedStudent = blackListDao.getBlackedStudentById(studentId);
        assertNull(blacklistedStudent, "Blacklisted student record should be deleted");

        // 验证相关预约记录已删除
        reservations = reservationDao.getAllStudentReservationInfo(testStudent);
        assertTrue(reservations.isEmpty(), "All reservations for the student should be deleted");
    }

}
