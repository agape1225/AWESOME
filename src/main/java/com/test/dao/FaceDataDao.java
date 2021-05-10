package com.test.dao;

import com.test.dto.FaceData;
import com.test.mapper.FaceDataMapper;
import com.test.mapper.TestMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FaceDataDao {
    @Autowired
    SqlSession sqlSession;

    public void addFaceData(int userNo, String frameId, FaceData faceData){
        try{
            System.out.println("start face data dao");
            FaceDataMapper faceDataMapper = sqlSession.getMapper(FaceDataMapper.class);
            faceDataMapper.addFaceData(userNo, frameId, faceData.getPos_x().getData(), faceData.getPos_y().getData());
            System.out.println("end face data dao");
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}
