package com.test.service.faceData;

import com.test.dto.FaceData;

public interface FaceDataService {
    void addFaceData(int userNo, String frameId, FaceData data);
}
