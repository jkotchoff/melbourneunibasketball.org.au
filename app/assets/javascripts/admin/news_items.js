$(
    function () {
      if (navigator.userAgent.match(/(iPhone|iPod|iPad|Android|Windows Phone|Windows Mobile)/i)) {
        $('body').addClass("touch-enabled");
      }
      
      $('#need_help').css('top', Math.round(($(window).height() - 120) / 2) + 'px');
      $(window).resize(function() {
        $('#need_help').css('top', Math.round(($(window).height() - 120) / 2) + 'px');
      });
      
        if ($(document).width() >= 480) {
          
          $("label").each(function(){
              var label = $(this);
              if (label.attr("data-help")){
                  label.css({
                      "background": "url(/assets/helper.png) no-repeat right center",
                      "padding-right": 34 + "px",
                      "width": ($(document).width() >= 768 ? 106 + "px" : "226px"),
                      "height": 21 + "px"
                  });

                  label.click(function(e){
                      alert( label.attr("data-help") );
                  });

                  label.mouseover(function(e){
                      var $tooltip = $("<div class='tooltip'>" + label.attr("data-help") + "</div>");
                      $tooltip.css({ "top": e.pageY + 5 + "px", "left": e.pageX + 5 + "px" });
                      $("body").append($tooltip);
                  });

                  label.mousemove(function(e){
                      $(".tooltip").css({"top": e.pageY + 5 + "px", "left": e.pageX + 5 + "px" });
                  });

                  label.mouseout(function(){
                      $(".tooltip").remove();
                  });
              }
          });
        }
    }
);
