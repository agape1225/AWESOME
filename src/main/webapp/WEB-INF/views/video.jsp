<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>

<head>
<meta charset="utf-8" />
      <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
      <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-tubeplayer/2.1.0/jquery.tubeplayer.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
</head>

<div id="app">
  <div id='youtube-video-player'></div>

  <div v-if = "show">
    <div v-if = "quiz[num].type == 0">
      {{quiz[num].question}}
      <input type="radio" name="type0" value="1">O</input>
      <input type="radio" name="type0" value="0">X</input>
    </div>

    <div v-if = "quiz[num].type == 1">
      {{quiz[num].question}}
      <div v-for = "x in quiz[num].checkboxEx">
        <input type="radio" name="type1" :value="x.num"> {{x.example}}</input>
      </div>
    </div>

    <div v-if = "quiz[num].type == 2">
      {{quiz[num].question}} <br>
      {{quiz[num].Ex}}
      <input type=text name="type2" v-model="answer"></input>
    </div>
    <button @click = "submit()">제출</button>
  </div>
</div>
<script>
query2json = function() {

     //query = location.href.split("?");
  console.log(${data});
     query = ${data}.split("?");
     str = query[1];
     var j, q;
     q = str.split("&");
     j = {};
     $.each(q, function(i, arr) {
      arr = arr.split('=');
      return j[arr[0]] = arr[1];
     });
     return j;

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
              {time: 20, question:'퀴즈1', type:'0', correct:'1'},
              //{time: 25, question:'퀴즈2', type:'0', correct:'0'},
              {time: 10, question:'퀴즈3',
              checkboxEx:[
                  {num: 1, example:"객체지향"},
                  {num: 2, example:"모바일"},
                  {num: 3, example:"웹개발"},
                  {num: 4, example:"UNIX서버"},
                  {num: 5, example:"선형대수"}]
                  , type:'1', correct:'3'
              },
              {time: 2, question:'퀴즈4', Ex:'대표적인 웹 브라우저는?', 
              type:'2', correct:['인터넷 익스플로러', 'internet']}
            ],
          show : false,
          num : 0,
          answer : "",
          answers : [] ,
        },
        methods : {
          submit : function() {
            // b = 123;
            // a = ` 
            //  "hello"  
            // "fefefe
            // ' grgjrig'  ${b}
            // `
            this.show = false;
            if(this.quiz[this.num].type == 0 || this.quiz[this.num].type == 1){
              t = `input[name="type${this.quiz[this.num].type}"]:checked`;
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
    //$('#quiz').hide();
    query = query2json();
    $("#youtube-video-player").tubeplayer({
        initialVideo: query.youtubeid ,
        onPlayerLoaded: function(){
          console.log('hello');
          $("#youtube-video-player").tubeplayer("seek", 90);
          setInterval( function() {
            currentTime = parseInt($("#youtube-video-player").tubeplayer("data").currentTime);
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