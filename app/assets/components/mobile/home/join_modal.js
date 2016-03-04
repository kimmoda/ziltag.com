import React from 'react'
import Modal from '../modal'
import Field from '../field'

export default class JoinModal extends React.Component {
  render() {
    let {onSelectPlatform, ...props} = {...this.props}
    return(
      <Modal
        dismissible
        headerTitle="Join Ziltag Partner"
        {...props}
      >
        <div className="ziltag-mobile-home__join">
          <form onSubmit={this.props.onSubmit}>
            <div className="ziltag-mobile-home__join-fields">
              <Field name="username" placeholder="USERNAME" />
              <Field name="email" placeholder="EMAIL" type="email" />
            </div>
            <div className="ziltag-mobile-home__join-instruction">Platform Selection</div>
            <div className="ziltag-mobile-home__join-platforms">
              <div className={this.classNameOfPlatform('general')} onClick={ () => { onSelectPlatform('general') } }>● General</div>
              <div className={this.classNameOfPlatform('tumblr')} onClick={ () => { onSelectPlatform('tumblr') } }>● Tumblr</div>
              <div className={this.classNameOfPlatform('blogger')} onClick={ () => { onSelectPlatform('blogger') } }>● Blogger</div>
            </div>
            <input type="hidden" name="platform" value={this.props.select} />
            <Field name={this.props.select == 'general' ? 'url' : 'blog_id'} placeholder={this.props.select == 'general' ? 'DOMAIN' : 'BLOG ID'} />
            <button className="ziltag-mobile-home__join-submit" type="submit">REGISTER</button>
            <div className="ziltag-mobile-home__join-error">{this.props.error}</div>
          </form>
        </div>
      </Modal>
    )
  }
  classNameOfPlatform(platform) {
    let className = 'ziltag-mobile-home__join-platform'
    if(this.props.select == platform) className += ' ziltag-mobile-home__join-platform--selected'
    return className
  }
}