<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ysw02
  Date: 2021-01-31
  Time: 오후 7:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

  <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-tubeplayer/2.1.0/jquery.tubeplayer.min.js"></script>
  <link href="<%=request.getContextPath()%>/resources/css/table.css" rel="stylesheet" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['집중시간',     ${concentrate}],
        ['집중하지 않은 시간',      ${un_concentrate}]

      ]);

      var options = {
        title: '집중도 분석'
      };

      var chart = new google.visualization.PieChart(document.getElementById('piechart'));

      chart.draw(data, options);
    }
  </script>
</head>
<body>
<div id="app" class="table-wrapper">
  <h2>집중도 분석 결과</h2>
  <table border=1 class="fl-table">
    <thead>
      <tr>
        <th>문제</th><th>정답</th><th>입력</th><th>집중도</th>
      </tr>
    </thead>
    <tbody v-for = "item, i in quiz">
      <tr v-if = "item.type == 0">
        <td>{{item.question}}</td>
        <td>
          <div v-if="item.correct == 0" > 
            X
          </div> 
          <div v-else> 
            O 
          </div>
        </td>
        <td>
          <div v-if="answers[i] == 0"> 
            X
          </div>
          <div v-else-if="answers[i] == 1"> 
            O
          </div> 
          <div v-else>
            O
          </div>
        </td>
        <td>
          <!--<div v-if="item.correct == answers[i]">
            상
          </div>
          <div v-else-if="answers[i]==undefined">
            하
          </div>
          <div v-else>
            중
          </div>-->
          상
        </td>
      </tr>
      <tr v-if = "item.type == 1">
        <td>
          {{item.question}}
          <div v-for = "x in item.checkboxEx">
            {{x.num}}. {{x.example}}
          </div>
        </td>
        <td>
          {{item.checkboxEx[item.correct-1].num}}. {{item.checkboxEx[item.correct-1].example}}
        </td>
        <td>
          {{answers[i]}}. {{item.checkboxEx[answers[i]].example}}
        </td>
        <td>
          <div v-if="item.correct == answers[i]"> 
            상
          </div>
          <div v-else-if="answers[i]==''"> 
            하
          </div>  
          <div v-else> 
            중
          </div>
        </td>
      </tr>
      <tr v-if = "item.type == 2">
        <td>{{item.question}}</td>
        <td>
          <div v-for = "x in item.correct">
            {{x}}
          </div>
        </td>
        <td>
          <div v-if = "answers[i]==''">
            미제출
          </div>
          <div v-else>
            {{answers[i]}}
          </div>
        </td>
        <td>
          <div v-for = "x in item.correct ">
            <div v-if="x == answers[i]"> 
              상
            </div>
            <div v-else-if="answers[i]==''"> 
              하
            </div> 
            <div v-else> 
              중
            </div>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</div>
<div class="outer">
  <div id="piechart" style="width: 900px; height: 500px;" class="inner"></div>
</div>
</body>
<script>
query2json = function() {
     query = location.href.split("?");
     str = query[1];
     var j, q;
     q = str.split("&");
     j = {};
     $.each(q, function(i, arr) {
      arr = arr.split('=');
      return j[arr[0]] = arr[1];
     });
     return j;

}


  vue = new Vue({
        el :"#app",
        data : {
            quiz : [
              {time: 5, question:'질문1: 맞는 것을 고르시오.', type:'0', correct:'1',},
              //{time: 25, question:'퀴즈2', type:'0', correct:'0'},
              {time: 10, question:'질문2: 아래에서 맞는 보기를 고르시오.',
              checkboxEx:[
                  {num: 1, example:"객체지향"},
                  {num: 2, example:"모바일"},
                  {num: 3, example:"웹개발"},
                  {num: 4, example:"UNIX서버"},
                  {num: 5, example:"선형대수"}]
                  , type:'1', correct:3, 
              },
              {time: 15, question:'질문3: 알맞은 답을 적으시오.',
              type:'2', correct:['인터넷 익스플로러']}
            ],
          show : false,
          num : 0,
          answer : "",
          answers : [undefined, 1, ""] ,
        },
        methods : {
            check : function() {
                console.log('inited.....');       
            }
          
          },
        mounted () {
                this.check();
          }
    });
</script>

