(function() {
  var SpeakerTooltip,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  SpeakerTooltip = (function() {
    function SpeakerTooltip(options) {
      this.options = options;
      this.destroy = __bind(this.destroy, this);
      this.adjust_styling_of = __bind(this.adjust_styling_of, this);
      this.show = __bind(this.show, this);
      this.fetch = __bind(this.fetch, this);
      this.user_interaction = __bind(this.user_interaction, this);
      this.hot_element = $(this.options.hot_element).not(this.options.skip);
      this.user_interaction();
    }

    SpeakerTooltip.prototype.user_interaction = function() {
      var _this = this;

      this.hot_element.click(function() {
        return window.location.href += "/palestrantes";
      });
      return this.hot_element.hover(function(e) {
        var link;

        link = $(e.currentTarget).attr("href");
        return _this.fetch("/palestrante/" + link, _this.show);
      }, this.destroy);
    };

    SpeakerTooltip.prototype.fetch = function(url, callback) {
      return this.request = $.get(url, callback);
    };

    SpeakerTooltip.prototype.show = function(data) {
      return this.adjust_styling_of($(data).appendTo("body"));
    };

    SpeakerTooltip.prototype.adjust_styling_of = function(element) {
      var left_pos;

      left_pos = $(".programacao").offset()["left"] + $(".programacao").outerWidth();
      return element.css({
        left: left_pos + "px",
        top: $(window).scrollTop() + 20 + "px"
      });
    };

    SpeakerTooltip.prototype.destroy = function() {
      var _ref;

      if ((_ref = this.request) != null) {
        _ref.abort();
      }
      return $(".speaker-info").remove();
    };

    return SpeakerTooltip;

  })();

  this.SpeakerTooltip = SpeakerTooltip;

}).call(this);
