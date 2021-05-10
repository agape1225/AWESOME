package com.test.controller;

import com.test.dto.FaceData;
import com.test.dto.Point;
import com.test.service.faceData.FaceDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class FaceDataController {

    private final SimpleDateFormat dateForServer = new SimpleDateFormat("yyyyMMddHHmmss_");

    @Autowired
    FaceDataService faceDataService;

    @RequestMapping(value = "/addData", method = RequestMethod.POST)
    public String addData(@RequestParam(value="dataList") List<String> dataList){
        try{

            Point[] pointArr = new Point[2];
            FaceData faceDataBuff = new FaceData();
            Date currentTime = new Date(); String regDateForServer = dateForServer.format(currentTime);

            String frameId = "frame_" + currentTime;

            for (String data: dataList) {

                if(data != null){
                    System.out.println(data);

                    String[] point = data.split(":");
                    String pName = point[0].replaceAll("[\\[\"\\{]","");
                    double pLoc = Double.parseDouble(point[1].replaceAll("[\\[\"\\{\\}\\]]",""));

                    if(pName.contains("x")){
                        Point buff = new Point();
                        buff.setPos(pName);
                        buff.setData(pLoc);

                        pointArr[0] = buff;

                    }else{

                        Point buff = new Point();
                        buff.setPos(pName);
                        buff.setData(pLoc);

                        pointArr[1] = buff;

                        faceDataBuff.setPos_x(pointArr[0]);
                        faceDataBuff.setPos_y(pointArr[1]);

                        faceDataService.addFaceData(1,frameId, faceDataBuff);

                    }

                    System.out.print(pName);
                    System.out.println(pLoc);
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:/";
    }
}
