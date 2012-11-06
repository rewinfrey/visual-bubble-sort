Bubble Sort
===============

[Demo](http://visual-bubble-sort.rickwinfrey.com)

About
----------

Bubble Sort is a visual representation of a bubble sort

The Bubble Sort algorithm is very simple:
* Starting with the beginning element of a set, compare two adjoining elements.
* If the left element > the right element, swap the elements
* The list is sorted when no swaps occur

When the number of elements being sorted is sufficiently large, Bubble Sort has a worst case O(n^2) computational cost (not efficient)

The visualization is a simple Rack-based app (Sinatra). Sorting and animation logic can be found in /public/js/bubble_sort.coffee || /public/js/bubble_sort.js

License
---------

This code is MIT Licensed:

Copyright (c) 2012 Rick Winfrey

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.