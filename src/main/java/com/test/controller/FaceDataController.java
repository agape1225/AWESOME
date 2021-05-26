package com.test.controller;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import com.test.dto.FaceData;
import com.test.dto.Point;
import com.test.service.faceData.FaceDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class FaceDataController {

    private final SimpleDateFormat dateForServer = new SimpleDateFormat("yyyyMMddHHmmss_");

    @Autowired
    FaceDataService faceDataService;

    @GetMapping("/testCsv")
    public String test(Model model){
        try{

            String []str = new String[3];
            str[0] = "1";
            str[1] = "2";
            str[2] = "3";

            List<String> dataList = new ArrayList<>();
            dataList.add("1");
            dataList.add("2");
            dataList.add("3");



            /*Map<String, Object> hmap = null;
            ArrayList<Map<String, Object>> list = new ArrayList<Map<String,Object>>();

            hmap = new HashMap<String, Object>();
            hmap.put("one", 1);
            hmap.put("two", "한글1");
            list.add(hmap);

            hmap = new HashMap<String, Object>();
            hmap.put("one", 11);
            hmap.put("two", "한글22");
            list.add(hmap);

            hmap = new HashMap<String, Object>();
            hmap.put("one", 111);
            hmap.put("two", "한글3");
            list.add(hmap);*/

            CSVWriter cw = new CSVWriter(new OutputStreamWriter(
                    new FileOutputStream("C:\\test.csv"),
                    "EUC-KR"),
                    ',',
                    '"');

            cw.writeNext(str);

            /*for(Map<String, Object> m : list) {
                //배열을 이용하여 row를 CSVWriter 객체에 write

            }*/

            cw.close();

        }catch (Exception e){
            e.printStackTrace();
        }
        return "index";
    }

    @GetMapping("/createData")
    public String main(Model model){
        try{

        }catch (Exception e){
            e.printStackTrace();
        }
        return "index";
    }

/*    @RequestMapping(value = "/createData/addData", method = RequestMethod.POST)
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
    }*/

    @RequestMapping(value = "/createData/addData", method = RequestMethod.POST)
    public String addData(@RequestParam(value="dataList") String[] dataList){
        try{

            if(dataList != null){

                System.out.println(dataList);

                String[] data  = new String[137];

                data[0] = "0";

                for(int i = 1; i < 137; i++){
                    String buff = dataList[i - 1].replaceAll("[\"\\{:x_y_\\}\\[\\]]","");
                    data[i] = buff;
                    //System.out.println(data[i] + " ");
                }

                CSVReader reader = new CSVReader(new FileReader("C:\\face_data.csv"));

                ArrayList<String[]> existing = new ArrayList<String[]>();

                String [] nextLine;
                //String [] buff = new String[137];

                while((nextLine = reader.readNext()) != null){
                    //System.out.println(nextLine.length);
                    String [] buff = new String[137];
                    for(int i = 0; i < nextLine.length; i++){

                        buff[i] = nextLine[i];
                    }
                    existing.add(buff);
                }

                existing.add(data);

                reader.close();

                /*CSVWriter cw = new CSVWriter(new OutputStreamWriter(
                        new FileOutputStream("C:\\test.csv"),
                        "EUC-KR"),
                        ',',
                        '"');*/

                CSVWriter cw = new CSVWriter(new FileWriter("C:\\face_data.csv"));

                for(String[] write: existing){
                    cw.writeNext(write);
                }
                cw.close();

                //Thread.sleep(5000);
            }




        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:/";
    }

    @RequestMapping(value = "/checkData")
    public String testData(){
        try{

            CSVReader reader = new CSVReader(new FileReader("C:\\test.csv"));
            String [] nextLine;
            ArrayList<String[]> existing = new ArrayList<String[]>();


            while((nextLine = reader.readNext()) != null){
                //System.out.println(nextLine.length);
                String [] buff = new String[137];
                for(int i = 0; i < nextLine.length; i++){

                    buff[i] = nextLine[i];
                    //System.out.print(nextLine[i] + " ");
                    //buff[i] = nextLine[i];
                }

                /*for(int i = 0; i < buff.length; i++){
                    System.out.print(buff[i] + " ");
                }
                System.out.println();*/

                existing.add(buff);
                //System.out.println();
                //existing.add(buff);
            }

            for(String[] data: existing){

                for(String s_data : data){
                    System.out.print(s_data + " ");
                }
                System.out.println();

            }


        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:/";
    }

}
