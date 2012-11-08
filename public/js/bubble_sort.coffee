class Animate
  constructor: (@id, @canvas_height, @canvas_width, @stroke, @frame_rate) ->
    this.ctx        = document.getElementById("#{@id}").getContext("2d")
    this.height     = @canvas_height
    this.width      = @canvas_width
    this.stroke     = @stroke
    this.list_size  = 0
    this.frame_rate = @frame_rate

  reset_canvas: ->
    this.ctx.clearRect(0, 0, this.height, this.width)

  get_list_size: (linked_list) ->
    this.list_size = linked_list.length

  draw_linked_list: (linked_list) ->
    length = 0
    current_node = linked_list.first
    current_node.state = "unsorted"
    while length < linked_list.length
      this.draw_frame(current_node)
      current_node = current_node.prev
      length += 1

  draw_array: (array) ->
    for element, element_index in array
      element.state = "unsorted"
      this.draw_frame(element)
      
  draw_frame: (current_node) ->
    switch current_node.state
      when "unsorted"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(100,100,100)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "sorted"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(255,153,0)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "swap"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(200,0,0)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "swapped"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(200,150,0)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "iteration"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(255,255,0)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "minimum"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(100,200,100)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "compare1"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(100,200,100)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)
      when "compare2"
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(200,100,200)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)      
      else
        this.ctx.clearRect(current_node.x * this.stroke, 0, this.stroke, this.height)
        this.ctx.fillStyle = "rgb(45,123,200)"
        this.ctx.fillRect(current_node.x * this.stroke, this.height - current_node.y, this.stroke, current_node.y)

  process_animation: (animation_list) ->
    if animation_list.length != 0
      new_frame = new Node(animation_list.first.x, animation_list.first.y)
      new_frame.state = animation_list.first.state
      this.draw_frame(new_frame)
      animation_list.remove_node(animation_list.first)
      window.setTimeout(
        () =>
          this.process_animation(animation_list)
        ,
          this.frame_rate
      )

class Node
  constructor: (@x, @y) ->
    this.x = @x
    this.y = @y

class LinkedList
  constructor: ->
    this.first  = null
    this.last   = null
    this.length = 0
    this.max    = 0

  # set the first pointer to the second node in the linked list, return the first node and reduce the length by one
  remove_node: (node) ->
    if this.length > 1
      if node == this.first
        this.first = node.prev
      if node == this.last
        this.last  = node.next
    else
      this.first = null
      this.last  = null
    node.prev = null
    node.next = null
    this.length -= 1
  
  # adds a new node to a linked list. first node is "next" to last node
  # first_node.prev -> second_node.prev -> third_node ...
  # first_node <- second_node.next <- third_node.next
  add_node: (node) ->
    if this.length == 0
      node.prev  = node
      node.next  = node
      this.first = node
      this.last  = node
    else
      this.first.next = node
      this.last.prev  = node
      node.prev       = this.first
      node.next       = this.last
      this.last       = node
    this.length += 1
    
  # checks if the linked list is empty (meaning the linked list length is == 0)
  is_empty: ->
    return this.length == 0

  add_animation_node: (node, state) ->
    temp_node       = new Node(node.x, node.y)
    temp_node.state = state
    this.add_node(temp_node)

class BubbleSort
  constructor: (@canvas_height, @canvas_width, @stroke) ->
    this.data_set        = []
    this.animation_list  = new LinkedList()
    this.canvas_height   = @canvas_height
    this.canvas_width    = @canvas_width
    this.stroke          = @stroke

  initialize_data: ->
    while this.data_set.length < (parseInt(this.canvas_width / this.stroke))
      this.data_set.push(new Node(this.data_set.length, parseInt((Math.random() * 1000 % this.canvas_height))))

  bubble_sort: ->
    switched = false

    for element, index in this.data_set
      if index != 0
        current   = element
        previous  = this.data_set[index - 1]

        this.animation_list.add_animation_node(current, "minimum")
        this.animation_list.add_animation_node(current, "minimum")

        if previous.y > current.y
          this.swap_data_points(previous, current, index)
          switched = true
        else
          this.animation_list.add_animation_node(previous, "unsorted")

    this.animation_list.add_animation_node(this.data_set.pop(), "sorted")

    this.bubble_sort() if switched == true

    if switched == false && this.data_set.length > 0
      for element in this.data_set
        this.animation_list.add_animation_node(element, "sorted")

  swap_data_points: (previous, current, index) ->
    # nastay nastay
    this.animation_list.add_animation_node(current, "minimum")
    this.animation_list.add_animation_node(previous, "compare2")
    this.animation_list.add_animation_node(current, "minimum")
    this.animation_list.add_animation_node(previous, "compare2")    

    previous.x = index
    current.x = index - 1
    this.data_set[index]   = previous
    this.data_set[(index-1)] = current
    
    # nastay nastay
    this.animation_list.add_animation_node(previous, "minimum")
    this.animation_list.add_animation_node(current, "compare2")
    this.animation_list.add_animation_node(previous, "minimum")
    this.animation_list.add_animation_node(current, "compare2")
    this.animation_list.add_animation_node(previous, "minimum")
    this.animation_list.add_animation_node(current, "compare2")
    this.animation_list.add_animation_node(current, "unsorted")

$(document).ready () ->
  # number in milliseconds to pause between animation frames
  frame_rate    = 40
  # number in pixels to determine width of data set lines
  stroke        = 35
  canvas_height = parseInt($('#bubble_sort').css('height').replace("px", ""))
  canvas_width  = parseInt($('#bubble_sort').css('width').replace("px", ""))
  
  # animate object draws unsorted data set, and processes the animation sequence for the bubble sort
  animate       = new Animate("bubble_sort", canvas_height, canvas_width, stroke, frame_rate)
  
  # contains unsorted data, as well as a linked list for recording the animation sequence to be drawn by the animation object
  bubble        = new BubbleSort(canvas_height, canvas_width, stroke)

  bubble.initialize_data()
  animate.draw_array(bubble.data_set)
  bubble.bubble_sort()
  animate.process_animation(bubble.animation_list)