<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.13/dist/vue.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    
</head>       
<body>
    <div id="app">   
        ID<input type=text v-model="id">
        PASSWORD<input type=password v-model="password">
        <button @click="login()" class="btn btn-outline-warning">로그인</button>
        <a href='form.html' class="btn btn-outline-warning">회원가입</a>
    </div>  
<script>
    new Vue({
        el :"#app",
        data : {
            id : "",
            password : ""
            },
        methods : {
            login : function() { 
                if(this.id == this.password){
                    location.href='videolist.jsp';
                }
                else{
                    alert("다시 입력해주세요.")
                }
            },
        }
    });    
    
</script>
</body>
</html>   

