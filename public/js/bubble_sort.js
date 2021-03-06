// Generated by CoffeeScript 1.3.3
(function() {
  var Animate, BubbleSort, LinkedList, Node;

  Animate = (function() {

    function Animate(id, canvas_height, canvas_width, stroke, frame_rate) {
      this.id = id;
      this.canvas_height = canvas_height;
      this.canvas_width = canvas_width;
      this.stroke = stroke;
      this.frame_rate = frame_rate;
      this.ctx = document.getElementById("" + this.id).getContext("2d");
      this.height = this.canvas_height;
      this.width = this.canvas_width;
      this.stroke = this.stroke;
      this.list_size = 0;
      this.frame_rate = this.frame_rate;
    }

    Animate.prototype.reset_canvas = function() {
      return this.ctx.clearRect(0, 0, this.height, this.width);
    };

    Animate.prototype.get_list_size = function(linked_list) {
      return this.list_size = linked_list.length;
    };

    Animate.prototype.draw_linked_list = function(linked_list) {
      var current_node, length, _results;
      length = 0;
      current_node = linked_list.first;
      current_node.state = "unsorted";
      _results = [];
      while (length < linked_list.length) {
        this.draw_frame(current_node);
        current_node = current_node.prev;
        _results.push(length += 1);
      }
      return _results;
    };

    Animate.prototype.draw_array = function(array) {
      var element, element_index, _i, _len, _results;
      _results = [];
      for (element_index = _i = 0, _len = array.length; _i < _len; element_index = ++_i) {
        element = array[element_index];
        element.state = "unsorted";
        _results.push(this.draw_frame(element));
      }
      return _results;
    };

    Animate.prototype.draw_frame = function(current_node) {
      switch (current_node.state) {
        case "unsorted":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(100,100,100)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "sorted":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(255,153,0)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "swap":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(200,0,0)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "swapped":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(200,150,0)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "iteration":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(255,255,0)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "minimum":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(100,200,100)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "compare1":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(100,200,100)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        case "compare2":
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(200,100,200)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
        default:
          this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height);
          this.ctx.fillStyle = "rgb(45,123,200)";
          return this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y);
      }
    };

    Animate.prototype.process_animation = function(animation_list) {
      var new_frame,
        _this = this;
      if (animation_list.length !== 0) {
        new_frame = new Node(animation_list.first.x, animation_list.first.y);
        new_frame.state = animation_list.first.state;
        this.draw_frame(new_frame);
        animation_list.remove_node(animation_list.first);
        return window.setTimeout(function() {
          return _this.process_animation(animation_list);
        }, this.frame_rate);
      }
    };

    return Animate;

  })();

  Node = (function() {

    function Node(x, y) {
      this.x = x;
      this.y = y;
      this.x = this.x;
      this.y = this.y;
    }

    return Node;

  })();

  LinkedList = (function() {

    function LinkedList() {
      this.first = null;
      this.last = null;
      this.length = 0;
      this.max = 0;
    }

    LinkedList.prototype.remove_node = function(node) {
      if (this.length > 1) {
        if (node === this.first) {
          this.first = node.prev;
        }
        if (node === this.last) {
          this.last = node.next;
        }
      } else {
        this.first = null;
        this.last = null;
      }
      node.prev = null;
      node.next = null;
      return this.length -= 1;
    };

    LinkedList.prototype.add_node = function(node) {
      if (this.length === 0) {
        node.prev = node;
        node.next = node;
        this.first = node;
        this.last = node;
      } else {
        this.first.next = node;
        this.last.prev = node;
        node.prev = this.first;
        node.next = this.last;
        this.last = node;
      }
      return this.length += 1;
    };

    LinkedList.prototype.is_empty = function() {
      return this.length === 0;
    };

    LinkedList.prototype.add_animation_node = function(node, state) {
      var temp_node;
      temp_node = new Node(node.x, node.y);
      temp_node.state = state;
      return this.add_node(temp_node);
    };

    return LinkedList;

  })();

  BubbleSort = (function() {

    function BubbleSort(canvas_height, canvas_width, stroke) {
      this.canvas_height = canvas_height;
      this.canvas_width = canvas_width;
      this.stroke = stroke;
      this.data_set = [];
      this.animation_list = new LinkedList();
      this.canvas_height = this.canvas_height;
      this.canvas_width = this.canvas_width;
      this.stroke = this.stroke;
    }

    BubbleSort.prototype.initialize_data = function() {
      var _results;
      _results = [];
      while (this.data_set.length < (parseInt(this.canvas_width / this.stroke))) {
        _results.push(this.data_set.push(new Node(this.data_set.length, parseInt(Math.random() * 1000 % this.canvas_height))));
      }
      return _results;
    };

    BubbleSort.prototype.bubble_sort = function() {
      var current, element, index, previous, switched, _i, _j, _len, _len1, _ref, _ref1, _results;
      switched = false;
      _ref = this.data_set;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        element = _ref[index];
        if (index !== 0) {
          current = element;
          previous = this.data_set[index - 1];
          this.animation_list.add_animation_node(current, "minimum");
          this.animation_list.add_animation_node(current, "minimum");
          if (previous.y > current.y) {
            this.swap_data_points(previous, current, index);
            switched = true;
          } else {
            this.animation_list.add_animation_node(previous, "unsorted");
          }
        }
      }
      this.animation_list.add_animation_node(this.data_set.pop(), "sorted");
      if (switched === true) {
        this.bubble_sort();
      }
      if (switched === false && this.data_set.length > 0) {
        _ref1 = this.data_set;
        _results = [];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          element = _ref1[_j];
          _results.push(this.animation_list.add_animation_node(element, "sorted"));
        }
        return _results;
      }
    };

    BubbleSort.prototype.swap_data_points = function(previous, current, index) {
      this.animation_list.add_animation_node(current, "minimum");
      this.animation_list.add_animation_node(previous, "compare2");
      this.animation_list.add_animation_node(current, "minimum");
      this.animation_list.add_animation_node(previous, "compare2");
      previous.x = index;
      current.x = index - 1;
      this.data_set[index] = previous;
      this.data_set[index - 1] = current;
      this.animation_list.add_animation_node(previous, "minimum");
      this.animation_list.add_animation_node(current, "compare2");
      this.animation_list.add_animation_node(previous, "minimum");
      this.animation_list.add_animation_node(current, "compare2");
      this.animation_list.add_animation_node(previous, "minimum");
      this.animation_list.add_animation_node(current, "compare2");
      return this.animation_list.add_animation_node(current, "unsorted");
    };

    return BubbleSort;

  })();

  $(document).ready(function() {
    var animate, bubble, canvas_height, canvas_width, frame_rate, stroke;
    frame_rate = 40;
    stroke = 35;
    canvas_height = parseInt($('#bubble_sort').css('height').replace("px", ""));
    canvas_width = parseInt($('#bubble_sort').css('width').replace("px", ""));
    animate = new Animate("bubble_sort", canvas_height, canvas_width, stroke, frame_rate);
    bubble = new BubbleSort(canvas_height, canvas_width, stroke);
    bubble.initialize_data();
    animate.draw_array(bubble.data_set);
    bubble.bubble_sort();
    return animate.process_animation(bubble.animation_list);
  });

}).call(this);
