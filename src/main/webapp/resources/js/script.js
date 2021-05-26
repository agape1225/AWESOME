

const video = document.getElementById('video')

Promise.all([
  faceapi.nets.tinyFaceDetector.loadFromUri('/resources/models'),
  faceapi.nets.faceLandmark68Net.loadFromUri('/resources/models'),
  faceapi.nets.faceRecognitionNet.loadFromUri('/resources/models'),
  faceapi.nets.faceExpressionNet.loadFromUri('/resources/models')
]).then(startVideo)

function startVideo() {
  navigator.getUserMedia(
    { video: {} },
    stream => video.srcObject = stream,
    err => console.error(err)
  )
}

video.addEventListener('play', () => {
  const canvas = faceapi.createCanvasFromMedia(video)
  document.body.append(canvas)
  const displaySize = { width: video.width, height: video.height }
  faceapi.matchDimensions(canvas, displaySize)
  setInterval(async () => {
    const detections = await faceapi.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions()).withFaceLandmarks().withFaceExpressions()
    const resizedDetections = faceapi.resizeResults(detections, displaySize)
    canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height)
    faceapi.draw.drawFaceLandmarks(canvas, resizedDetections)

    const landmarks = await faceapi.detectFaceLandmarks(video)
    //landmarks.get()
    const getMouth = landmarks.getMouth()
    const getLeftEye = landmarks.getLeftEye()
    const getRightEye = landmarks.getRightEye()

    to_ajax(JSON.stringify(landmarks.positions));

    console.log("Mouth Position = "+JSON.stringify(getMouth))
    console.log("Left Eye Position = "+JSON.stringify(getLeftEye))
    console.log("Right Eye Position = "+JSON.stringify(getRightEye))
    //sleep(3000)

  }, 100)
})

function to_ajax(data){

  var objParams = {
    "dataList"      : data
  };

  $.ajax({
    url         :   "/createData/addData",
    dataType    :   "json",
    type        :   "post",
    data        :   objParams,
    success     :   function(retVal){
      if(retVal.code == "OK") {
        alert(retVal.message);
      } else {
        alert(retVal.message);
      }
    },
    error       :   function(request, status, error){
      console.log("AJAX_ERROR");
    }
  });
}




