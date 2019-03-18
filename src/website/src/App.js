import React, { useState } from 'react';
import P5Wrapper from './P5Wrapper';
import './App.css';

import sketch from './components/face/sketch'
import Menu from './components/menu/index'

function App() {
  const [robot, setRobot] = useState({
    emotion: "happy",
    currentPage: "face"
  })

  if (robot.currentPage === "face")
    return <P5Wrapper sketch={sketch} />
  else if (robot.currentPage === "menu")
    return <Menu />
}


export default App;
