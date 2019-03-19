import React, { useState } from 'react';
import { Button } from 'antd';
import P5Wrapper from './P5Wrapper';
import './App.css';

import sketch from './components/face/sketch'
import Menu from './components/menu/index'

function App() {

  const [currentPage, setCurrentPage] = useState("face");
  const [emotion, setEmotion] = useState("random");
  const [blinking, setBlinking] = useState(true);

  if (currentPage === "face") {
    return (
      <div>
        <P5Wrapper 
          sketch={sketch}
          emotion={emotion}
          blinking={blinking}
        />


        <Button type="primary" onClick={() => setEmotion("sad")}>Become Sad</Button>
        <Button type="primary" onClick={() => setEmotion("happy")}>Become Happy</Button>
        
      </div>
    )
  }
  else if (currentPage === "menu")
    return <Menu />
}

export default App;
