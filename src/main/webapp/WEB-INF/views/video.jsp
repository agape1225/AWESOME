<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>

<head>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
  <script defer src = "resources/js/face-api.min.js"></script>
  <script defer src = "resources/js/script.js"></script>
<meta charset="utf-8" />
      <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
      <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-tubeplayer/2.1.0/jquery.tubeplayer.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
      <link href="<%=request.getContextPath()%>/resources/css/video.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest"></script>

  <style>

    /*#user{
      width:300px;
      margin:auto;
    }*/
    .topcorner{
      position:absolute;
      top:0;
      right:0;
      border: 1px solid black;
    }
    #subbtn{
      margin: 0 auto;
    }
    #submit{
      margin: 0 auto;
    }

  </style>

</head>

<div id="app">

  <div class="wrapper">

  </div>
  <h2>{{object}}</h2>


  <div id='youtube-video-player'></div>

  <!--<div class="topcorner">
    <button onclick="clear_data()">clear</button>
    <form action="/createData/getGraphData" method="post">
      <input type="hidden" id="dataList" name="dataList"/>
      <button onclick="setData()">학습 종료</button>
    </form>
  </div>-->

  <div id="user" class="topcorner">

    <div class="inner">
      <form class="form">
        <button onclick="clear_data()" class="btn">clear</button>
      </form>
      <div style="float:left;"></div>
      <form action="/createData/getGraphData" method="post" class="form">
        <input type="hidden" id="dataList" name="dataList" id="inputsub"/>
        <button onclick="setData()" class="btn">학습 종료</button>
      </form>

    </div>
    <div class="content"><video id="video" width="360" height="280" autoplay muted></video></div>
  </div>


  <div v-if = "show" id="atQuiz">
    <div v-if = "quiz[num].type == 0">   
      {{quiz[num].question}}<br>
      <input type="radio" name="type0" value="1" style="width:20px; height:20px; border:1px;">O</input>
      <input type="radio" name="type0" value="0" style="width:20px; height:20px; border:1px;">X</input>
    </div>
    <div v-if = "quiz[num].type == 1">
      {{quiz[num].question}}
      <div  v-for = "x in quiz[num].checkboxEx">
        <input type="radio" name="type1" :value="x.num" style="width:20px; height:20px; border:1px;"> {{x.example}}</input>
      </div>
    </div>
    <div v-if = "quiz[num].type == 2">
      {{quiz[num].question}} <br>
      {{quiz[num].Ex}}
      <input type=text name="type2" v-model="answer" style="width:300px; font-size:20px;"></input>
    </div>



    <!--<button @click = "submit()">제출</button>-->
  </div>
</div>
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
     return '${youtubeid}';

     /*
     a = {id:'4343', name:'홍'}

    a["youtubeid"] = 'fsfwefwefwe';
    a["seek"] = '0:40';

    {youtubeid:'fwfwfew', seek:'0:40'}
     */
}

  /*
  query = location.href.split("?");
  namevalue = query[1].split("&");
  tokens = namevalue[0].split("=");
  seek = namevalue[1].split("=");
  */

  vue = new Vue({
        el :"#app",
        data : {
            quiz : [
              {time: 1, question:'질문1: 맞는 것을 고르시오.', type:'0', correct:'1'},
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
              {time: 20, question:'질문3: 알맞은 답을 적으시오.',
              type:'2', correct:['인터넷 익스플로러']}
            ],
          show : false,
          num : 0,
          answer : "",
          answers:[],
          object : "객제지향프로그래밍1" ,
        },
        methods : {
          submit : function() {
            this.show = false;
            if(this.quiz[this.num].type == 0 || this.quiz[this.num].type == 1){
              t = `input[name="type{{this.quiz[this.num].type}}"]:checked`;
            //console.log(t);
            var radioVal = $(t).val();
            //alert(radioVal);  
            this.answers.push(radioVal);
            }
            if(this.quiz[this.num].type == 2){
              var textVal = this.answer;
              this.answers.push(textVal);
            }
            console.log(this.answers);
          }
        }
    });
  $(document).ready( function() {
    var buff = query2json();
    //$('#quiz').hide();
/*    var buff = ${youtubeid};
    console.log("query = " + buff);*/
    $("#youtube-video-player").tubeplayer({
        /*initialVideo: query.youtubeid ,*/
        initialVideo: buff,
        onPlayerLoaded: function(){
          console.log('hello');
          $("#youtube-video-player").tubeplayer("seek", 90);
          setInterval( function() {
            currentTime =  parseInt($("#youtube-video-player").tubeplayer("data").currentTime);
            for(i = 0 ; i < vue.quiz.length; i++ ){
              if(currentTime == vue.quiz[i].time){
                //document.exitFullscreen();
                vue.num = i;
                //$('#quiz').show();
                vue.show = true;
                setTimeout(function(){
                  //$('#quiz').hide();
                  if ( vue.show == true ) {
                    vue.submit();
                    vue.show = false;
                  }
                  //document.documentElement.requestFullscreen();
                }, 5000);
            }
            }
          } ,1000);
          }
      });
  });
</script>