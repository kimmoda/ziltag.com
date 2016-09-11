import React from 'react'
import './index.scss'
import hljs from 'highlight.js'

export default class Demo extends React.Component {
  componentDidMount(){
    hljs.highlightBlock(this.refs.code)
  }
  render () {
    return (
      <div className="ziltag-landing-demo">
        <div className="ziltag-landing-demo__code">
          <pre style={{margin: 0}}><code ref="code" class="html">{`<html>
  <head></head>
  <body>
    <img src="//fakeimg.pl/400x200" />
    <script src="//ziltag.com/plugin.js"
      data-ziltag="96ceeb"></script>
  </body>
</html>`}</code></pre>
        </div>
        <div className="ziltag-landing-demo__preview">
          <img src="//fakeimg.pl/400x200" />
        </div>
      </div>
    )
  }
}