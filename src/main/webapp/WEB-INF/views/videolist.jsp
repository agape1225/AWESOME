<%@page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
     <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
     <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
     <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
     <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-tubeplayer/2.1.0/jquery.tubeplayer.min.js"></script>
     <%--<link href="css/table.css" rel="stylesheet" />--%>
      <link href="<%=request.getContextPath()%>/resources/css/table.css" rel="stylesheet" />
  </head>
  <body>
    <h2>강의목록</h2>
    <div id='app' class="table-wrapper">
    <table border=1  class="fl-table">
      <thead>
        <tr>
            <th>수강과목</th><th>동영상목록</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="x in item">
            <td>
              {{x.title}}
            </td>
            <td>
              <ul v-for="y in x.videos">
                <li>
                  <button @click="video(y.youtubeid, y.seek)" class="wrap">[{{y.name}}-{{y.youtubeid}}]</button>
                    <%--<form action="/startVideo" method="post">
                        <input type="hidden" name="youtubeid" value="{{y.youtubeid}}">
                        <input type="hidden" name="seek" value={y.seek}>
                        <button>[{{y.name}}-{{y.youtubeid}}]</button>
                    </form>--%>
                </li>
              </ul></td>
        </tr>
      </tbody>
    </table>
    <div id='youtube-video-player'></div>
    </div>
    <script>
  new Vue({
      el :"#app",
      data : {
        item:[
        {
          title:'모바일 프로그래밍',
          videos:[
            {name:"모바일 프로그래밍1", youtubeid:"7cazueAzrdk" },
            {name:"모바일 프로그래밍2", youtubeid:'WlJszSmK_es'},
            {name:"모바일 프로그래밍3", youtubeid:'mlxhD7M8Nsg'}]
        },
        {
          title:'웹개발기초',
          videos:[
            {name:"웹개발기초1", youtubeid:"ffENjt7aEdc"},
            {name:"웹개발기초2", youtubeid:'33DjsANwlJk'},
            {name:"웹개발기초3", youtubeid:'gqg-toXZ_rE'}
          ]
        },
        {
          title:'객체지향프로그래밍',
          videos:[
            {name:"객체지향프로그래밍1", youtubeid:"dy9yQIx38u8", seek:'4:20'},
            {name:"객체지향프로그래밍2", youtubeid:'jpcXlhgEzmQ'},
            {name:"객체지향프로그래밍3", youtubeid:'hvTuZshZvIo'} ]
        }
     ]},
     methods : {
       video : function(youtubeid, seek){
         location.href="startVideo?youtubeid=" + youtubeid + "&seek=" + seek;
       }
     }
  });
  </script>
</body>
</html>
