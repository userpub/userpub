angular.module('userpub')
  .filter('autolink', function(){

    var urlPattern = /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/gi;

    var normalize = function(arr){
      var result = {};
      for (var i = 0, l = arr.length; i < l; i++) {
        if (!result.hasOwnProperty(arr[i])) {
          result[arr[i]] = arr[i];
        }
      }
      return result;
    };

    return function(text, target){
      angular.forEach(text.match(urlPattern), function(url) {  
        target = target || "_blank";
        if (url.match(/\.(?:png|jpg|gif|webp)$/)) {
          var className = "chat-image";
          var content = "<img src=\"" + url + "\" class=\"img-responsive\">";
        } else {
          var className = "chat-link";
          var content = url;
        }
        
        text = text.replace(new RegExp(url, 'g'), '<a target="' + target + '" href="'+ url + '" class="' + className + '">' + content +'</a>');
      });
      return text;  
    };

  });