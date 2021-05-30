<%@page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest"></script>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
  <script defer src = "resources/js/face-api.min.js"></script>
  <script defer src = "resources/js/script.js"></script>
  <style>

    body {
      margin: 0;
      padding: 0;
      width: 100vw;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    canvas {
      position: absolute;
    }

    .wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .content {
      font-family: system-ui, serif;
      font-size: 2rem;
      padding: 3rem;
      border-radius: 1rem;
    }

    .topcorner{
      position:absolute;
      top:0;
      right:0;
    }
  </style>
</head>
<body>

  <%--<h1> Test another tag</h1>--%>


  <div class="topcorner"><%--<button onclick="to_ajax()">그래프</button>--%><button onclick="clear_data()">clear</button>


    <form action="/createData/getGraphData" method="post">
      <input type="text" id="dataList" name="dataList"/>
      <button onclick="setData()">그래프</button>
    </form>
  </div>

  <div class="wrapper">
    <div class="content"><video id="video" width="720" height="560" autoplay muted></video></div>
  </div>
  <%--<video id="video" width="720" height="560" autoplay muted></video>--%>
</body>
</html>