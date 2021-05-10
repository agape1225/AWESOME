package com.test.service.faceData;

import com.test.dao.FaceDataDao;
import com.test.dto.FaceData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FaceDataServiceImp implements FaceDataService{
    @Autowired
    FaceDataDao faceDataDao;

    @Override
    public void addFaceData(int userNo, String frameId, FaceData data) {
        System.out.println("Start FaceDataService");
        faceDataDao.addFaceData(userNo, frameId, data);

    }
}
