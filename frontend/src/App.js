import logo from './logo.svg';
import './App.css';
import { vediosource } from './url.js'

function App() {
  return (
    <div className="App">
    <h1>HotPrimeFlix</h1>
     <video id="videoPlayer" width="70%" controls muted="muted" autoplay>
            <source src={vediosource} type="video/mp4" />
        </video>
    </div>
  );
}

export default App;

