class Animate
  constructor: (@id, @canvas_height, @canvas_width, @stroke, @frame_rate) ->
    this.ctx        = document.getElementById("#{@id}").getContext("2d")
    this.height     = @canvas_height
    this.width      = @canvas_width
    this.stroke     = @stroke
    this.last_node1 = null
    this.last_node2 = null
    this.steps      = 0
    this.data_size  = 0
    this.frame_rate = @frame_rate

  reset_canvas: ->
    this.ctx.clearRect(0, 0, this.height, this.width)

  draw_data_set: (data_set) ->
    this.data_size = data_set.length
    for num, num_index in data_set
      this.ctx.fillStyle = "rgb(45,123,200)"
      this.ctx.fillRect(num_index * this.stroke, this.height - num, this.stroke, num)

  draw_current: (x, y) ->
    this.ctx.clearRect(x * this.stroke, 0, this.stroke, this.height)
    this.ctx.fillStyle = "rgb(51, 204, 102)"
    this.ctx.fillRect(x * this.stroke, this.height - y, this.stroke, y)

  draw_current_two: (x, y) ->
    this.ctx.clearRect(x * this.stroke, 0, this.stroke, this.height)
    this.ctx.fillStyle = "rgb(255, 142, 10)"
    this.ctx.fillRect(x * this.stroke, this.height - y, this.stroke, y)

  draw_last: (x, y) ->
    this.ctx.clearRect(x * this.stroke, 0, this.stroke, this.height)
    this.ctx.fillStyle = "rgb(150,123,200)"
    this.ctx.fillRect(x * this.stroke, this.height - y, this.stroke, y)

  draw_progression: (progression) ->
    this.steps = progression.length if this.steps == 0

    if progression.length != 0
      current = progression.shift()
      this.draw_current(current.x, current.y)
      if progression.length != 0
        next = progression.shift()
        this.draw_current_two(next.x, next.y)
      this.last_node1 = current if current
      this.last_node2 = next if next
      window.setTimeout(
        () =>
          this.draw_last(this.last_node1.x, this.last_node1.y) if this.last_node1 != null
          this.draw_last(this.last_node2.x, this.last_node2.y) if this.last_node2 != null
          this.draw_progression(progression)
        ,
          this.frame_rate
      )
    else
      $('#steps').html("#{this.steps} comparative steps were required to sort #{this.data_size} elements")

  in_progression: (current_node, progression) ->
    for node in progression
      if current_node.x == node.x && current_node.y == node.y
        return true
    return false

class Node
  constructor: (@x, @y) ->
    this.x = @x
    this.y = @y

class BubbleSort
  constructor: (@canvas_height, @canvas_width, @stroke)->
    this.data_set        = []
    this.progression     = []
    this.canvas_height   = @canvas_height
    this.canvas_width    = @canvas_width
    this.stroke          = @stroke

  initialize_data: ->
    while this.data_set.length < (parseInt(this.canvas_width / this.stroke))
      this.data_set.push(parseInt((Math.random() * 1000 % this.canvas_height)))

  bubble_sort: ->
    switched = false
    for num, num_index in this.data_set
      if num_index != 0
        current_node = new Node(num_index, num)
        last_node    = new Node((num_index-1), this.data_set[num_index-1])
        if last_node.y > current_node.y
          this.swap_data_points(last_node, current_node, num_index)
          this.swap_nodes(last_node, current_node, num_index)
          this.record_progression(last_node, current_node)
          switched = true
    this.bubble_sort() if switched == true

  swap_data_points: (last_node, current_node, num_index) ->
    this.data_set[num_index]   = last_node.y
    this.data_set[num_index-1] = current_node.y

  swap_nodes: (last_node, current_node, num_index) ->
    last_node.x     = num_index
    current_node.x  = num_index-1

  record_progression: (last_node, current_node) ->
    this.progression.push(last_node)
    this.progression.push(current_node)

$(document).ready () ->
  # number in milliseconds to pause between animation frames
  frame_rate    = 25
  # number in pixels to determine width of data set lines
  stroke        = 20
  canvas_height = parseInt($('#bubble_sort').css('height').replace("px", ""))
  canvas_width  = parseInt($('#bubble_sort').css('width').replace("px", ""))
  animate       = new Animate("bubble_sort", canvas_height, canvas_width, stroke, frame_rate)
  bubble        = new BubbleSort(canvas_height, canvas_width, stroke)
  bubble.initialize_data()
  animate.draw_data_set(bubble.data_set)
  bubble.bubble_sort()
  animate.draw_progression(bubble.progression)