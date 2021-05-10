package com.test.mapper;

import org.apache.ibatis.annotations.Param;

public interface FaceDataMapper {
    void addFaceData(@Param("userNo") int userNo, @Param("frameId") String frameId,
                     @Param("pointX") double pointX, @Param("pointY") double pointY);
}
