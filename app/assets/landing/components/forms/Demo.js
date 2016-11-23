import React from 'react'
import Button from 'ziltag-elements/dist/Button'
import translate from 'hoc/translate'
import FieldButton from 'ziltag-elements/dist/FieldButton'

class Demo extends React.Component {
  constructor(props){
    super(props)
    this.boundRef = c => this._form = c
    this.boundOnRequestSend = url => {this._form.checkValidity() && this.props.onRequestSend(url)}
  }

  render() {
    const {defaultWidth, extendedWidth, onRequestSend, t} = this.props
    return (
      <form ref={this.boundRef} onSubmit={preventDefault}>
        <FieldButton
          name="url"
          buttonText={t('preview_on_your_website')}
          placeholder={t('please_enter_your_websites_url')}
          defaultWidth={defaultWidth}
          extendedWidth={extendedWidth}
          onRequestSend={this.boundOnRequestSend}
          type="url"
          required
          />
        <button style={{display: 'none'}}/>
      </form>
    )
  }
}

function preventDefault(e){e.preventDefault()}

export default translate(Demo)
