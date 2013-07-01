(function() {
  var Gallery,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Gallery = (function() {
    function Gallery(options) {
      this.options = options;
      this.browser_history = __bind(this.browser_history, this);
      this.keyboard_interactions = __bind(this.keyboard_interactions, this);
      this.push_state = __bind(this.push_state, this);
      this.change_content = __bind(this.change_content, this);
      this.fetch_content = __bind(this.fetch_content, this);
      this.select_new_media = __bind(this.select_new_media, this);
      this.select_elements();
      this.make_clickable();
      this.keyboard_interactions();
      this.browser_history();
    }

    Gallery.prototype.select_elements = function() {
      this.main_media = $(this.options.main_media);
      this.gallery_links = $(this.options.gallery_links);
      return this.media_wrapper = $(this.options.media_wrapper);
    };

    Gallery.prototype.make_clickable = function() {
      return this.gallery_links.on("click", this.select_new_media);
    };

    Gallery.prototype.select_new_media = function(event) {
      var link;

      link = $(event.currentTarget).attr("href");
      this.fetch_content(this.change_content, link);
      return false;
    };

    Gallery.prototype.fetch_content = function(callback, link) {
      var _this = this;

      return $.get(link, function(data) {
        _this.change_content(data);
        return _this.push_state({
          html: data,
          page_title: "Eventos CTE",
          link: link
        });
      });
    };

    Gallery.prototype.change_content = function(data) {
      var _this = this;

      return this.main_media.animate({
        opacity: 0
      }, 100, "swing", function() {
        _this.media_wrapper.html(data);
        if (_this.main_media.is("img")) {
          _this.main_media.css({
            opacity: 0
          }).load(function() {
            return $(this).animate({
              opacity: 1
            }, 100);
          });
        }
        _this.select_elements();
        return _this.make_clickable();
      });
    };

    Gallery.prototype.push_state = function(options) {
      return window.history.pushState(options, "", options.link);
    };

    Gallery.prototype.keyboard_interactions = function() {
      return $("html").keyup(function(e) {
        var media_to_go;

        media_to_go = (function() {
          switch (e.which) {
            case 37:
              return $(".media-gallery .active").prev();
            case 39:
              return $(".media-gallery .active").next();
            default:
              return null;
          }
        })();
        if (media_to_go !== null) {
          media_to_go.click();
        }
        return false;
      });
    };

    Gallery.prototype.browser_history = function() {
      var _this = this;

      return window.onpopstate = function(e) {
        if (e.state !== null) {
          return _this.change_content(e.state.html);
        }
      };
    };

    return Gallery;

  })();

  this.Gallery = Gallery;

}).call(this);
