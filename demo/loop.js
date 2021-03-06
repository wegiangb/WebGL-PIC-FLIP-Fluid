'use strict'

import Stats from 'stats-js'

export default function(shouldUpdate, update) {
  var lastTime = 0;
  var frameRequest;
  var running = false;
  // var execStats = new Stats()
  var frameStats = new Stats()
  
  function tick(total) {
    var elapsed = total - lastTime
    
    lastTime = total;

    // execStats.begin()
    frameStats.begin()
    update(elapsed)
    frameStats.end()
    // execStats.end()

    if (shouldUpdate()) {
      running = true
      frameRequest = requestAnimationFrame(tick)
      
    } else {
      running = false
    }
  }

  function start() {
    if (!running) {
      lastTime = 0
      // frameStats.begin()
      tick(0)
    }
  }

  function stop() {
    running = false
  }
  
  return {
    tick: function() {
      if (!running) {
        // frameStats.begin()
        frameRequest = requestAnimationFrame(tick)
      }
    },
    start,
    stop,
    // execStats,
    frameStats
  }
}