import Modal from 'Modal'
import ModalButton from 'ModalButton'
import Highlight from 'highlight.js'
import DemoForm from 'forms/Demo'
import translate from 'hoc/translate'
import Header from 'Header'

import React from 'react'
import Button from 'ziltag-elements/dist/Button'
import {Link} from 'react-router'
import {connect} from 'react-redux'

require('highlight.js/styles/atom-one-light.css')
require('./index.css')

const example = `<img src="sample.jpg">

<script
  src="https://ziltag.com/plugin.js"
  data-ziltag="YOUR_TOKEN">
</script>`

class Home extends React.Component {
  componentDidMount() {
    require('object-fit-images')(this._cover)
  }

  render() {
    const {t, isSignedIn, isWide} = this.props
    return (
      <div className="p-home">
        <div className="p-home__cover">
          <img ref={cover => this._cover = cover} className="p-home__cover-image" src={require('./loli_2048.jpg')} data-ziltag-switch="false"/>
          <Header>
            <Link className="p-home__auth-button p-home__auth-button--doc" to="/doc" style={{textDecoration: 'none', color: '#333333', fontSize: isWide ? '2vw' : 14, fontWeight: 500}}>{t('doc')}</Link>
          </Header>
          <div className="p-home__intro">
            <div style={{textAlign: 'center'}}><div className="p-home__title">{t('title')}</div></div>
            <div className="p-home__subtitle">{t('subtitle')}</div>
            <div className="p-home__demo-form"><DemoForm/></div>
          </div>
        </div>
        <div className="p-home__usage">
          <div className="p-home__usage-example">
            <div className="p-home__title" style={{textAlign: 'center'}}>{t('dead_simple_install')}</div>
            <pre className="p-home__code hljs html" dangerouslySetInnerHTML={{__html: Highlight.highlight('html', example).value}}/>
          </div>
          <div className="p-home__sample-image-wrapper"><img className="p-home__sample-image" src={require('./sample.jpg')}/></div>
        </div>
        <div className="p-home__get-start">
          <div style={{textAlign: 'center'}}><div className="p-home__title">{t('get_started_now')}</div></div>
          <div style={{marginTop: isWide ? '2vw' : 26}}><ModalButton width={isWide ? null : 164} text={t('join_now')} modalName="signUp"/></div>
          <div style={{marginTop: isWide ? '1vw' : 16}}><ModalButton width={isWide ? null : 164} text={t('watch_video')} color="gray" modalName="video" modalMode="center"/></div>
        </div>
        <div className="p-home__footer">
          <div className="p-home__copyright">© Ziltag Inc., 2016. All Rights Reserved.</div>
          <ul className="p-home__links">
            <li className="p-home__link"><a href="http://blog.ziltag.com" target="_blank" rel="noopener">{t('blog')}</a></li>
            <li className="p-home__link"><a href="http://help.ziltag.com" target="_blank" rel="noopener">{t('support')}</a></li>
            <li className="p-home__link"><a href="https://ziltag.zendesk.com/hc/en-us/requests/new" target="_blank" rel="noopener">{t('suggest_new_features')}</a></li>
            <li className="p-home__link"><a href="http://blog.ziltag.com/terms" target="_blank" rel="noopener">{t('terms')}</a></li>
            <li className="p-home__link"><a href="http://blog.ziltag.com/privacy/" target="_blank" rel="noopener">{t('privacy')}</a></li>
            <li className="p-home__link"><a href="https://www.dropbox.com/sh/a123sehmataicuo/AAAQGPJAELXaSrdLOphnttR7a" target="_blank" rel="noopener">Press Kit</a></li>
          </ul>
          <ul className="p-home__icon-links">
            <li className="p-home__icon-link p-home__icon-link--github"><a href="https://github.com/ziltag/ziltag-community" target="_blank" rel="noopener"></a></li>
            <li className="p-home__icon-link p-home__icon-link--twitter"><a href="https://twitter.com/ziltagapp" target="_blank" rel="noopener"></a></li>
          </ul>
        </div>
        <Modal/>
      </div>
    )
  }
}

export default connect(
  state => ({
    isSignedIn: state.isSignedIn,
    isWide: state.window.width >= 2048
  })
)(translate(Home))
