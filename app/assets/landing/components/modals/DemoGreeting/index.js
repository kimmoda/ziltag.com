import React from 'react'
import translate from 'hoc/translate'
import Button from 'ziltag-elements/dist/Button'
import URI from 'urijs'
import './index.css'

class DemoGreeting extends React.Component {
  render() {
    const {name, url, t, onStart} = this.props
    return (
      <div className="l-demo-greeting">
        <div className="l-demo-greeting__title">Hello{name && ` ${name}`}!</div>
        <div className="l-demo-greeting__body">{t('welcome_we_re_excited')}</div>
        <div className="l-demo-greeting__button-wrapper"><Button onClick={onStart} width="100%" text={t('start')}/></div>
        <hr className="l-demo-greeting__hr"/>
        <div className="l-demo-greeting__footer" dangerouslySetInnerHTML={{__html: t('this_is_a_demo_applied_to', {url: URI(this.props.url).host()})}}/>
      </div>
    )
  }
}

export default translate(DemoGreeting)
