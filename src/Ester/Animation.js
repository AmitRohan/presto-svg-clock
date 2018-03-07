exports["logAny"]  = function(a) {
  console.log(a);
}

exports.getById = function(id) {
  id= id.value0;
  return document.getElementById(id);   
}

exports.transform = function(mode) {
  return function (value) {
    return function(svgObj) {
        value= value.value0;
        svgObj.setAttribute("transform", mode+"("+value+")");
        return svgObj
      }
  }
}

// move ELement along the path
function move(el, path, l,repeatCount) {
    var n = 0
    var motionCount=0
    return function anim(timestamp) {
      if(n > l) {
        n = 0
        motionCount++;
      }
      var point = path.getPointAtLength(n)
      el.setAttribute("transform", "translate("+point.x + "," +point.y + ")");
      n += 2
      if(repeatCount == -1 || motionCount < repeatCount)
        requestAnimationFrame(anim)
    }
  }

exports.rotateAt = function(value) {
  return function (cx) {
    return function (cy) {
      return function(svgObj) {
        value= value.value0;
        if(svgObj){
          svgObj.setAttribute("transform", "rotate("+value+", "+cx+", "+cy+")");
        }
        return svgObj
      }
    }
  }
}

exports.startFollowAnimation = function(idToFollow) {
  return function (repeatCount) {
      return function(svgObj) {
      idToFollow= idToFollow.value0;
      if(svgObj){
        var path = document.getElementById(idToFollow);
        var l = path.getTotalLength()
        requestAnimationFrame(move(svgObj, path, l, repeatCount))
      }
      return svgObj
    }
  }
}
