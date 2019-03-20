import React, { useState } from 'react';
import { Button } from 'antd';
import P5Wrapper from './P5Wrapper';
import './App.css';

import raspi from 'raspi';
import { Serial } from 'raspi-serial';

import sketch from './components/face/sketch'
import Menu from './components/menu/index'

export default function App() {

  const [currentPage, setCurrentPage] = useState("face");
  const [emotion, setEmotion] = useState("random");
  const [blinking, setBlinking] = useState(true);
  const [serialMsg, setSerialMsg] = useState("hf");

  if (currentPage === "face") {
    return (
      <div>
        <P5Wrapper 
          sketch={sketch}
          emotion={emotion}
          blinking={blinking}
        />
        <Movement message={serialMsg} />

        <Button type="primary" onClick={() => setEmotion("sad")}>Become Sad</Button>
        <Button type="primary" onClick={() => setEmotion("happy")}>Become Happy</Button>
        
      </div>
    )
  }
  else if (currentPage === "menu")
    return <Menu />
}

raspi.init(() => {
  let serial = new Serial();
  serial.open(() => {
    serial.on('data', (data) => {
      process.stdout.write(data);
    });
    //serial.write('Happy')
  })
})

function Movement(props) {
  while(1) {
    serial.write(props.message);
    setTimeout(500);
  }
}

export default serial;