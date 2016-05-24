import './index.scss'
import React, { PropTypes } from 'react'
import Button from '../../Button'
import DomainFields from '../DomainFields'

export default class Domain extends React.Component {
  render () {
    const {fields, fields: {platform, url, tumblr, blogger}, handleSubmit, error, action, url: previousURL} = this.props
    const isUpdate = action == 'update'
    const title = isUpdate ? 'Edit Domain' : 'Add New Domain'
    const platformsStyle = {marginTop: isUpdate ? 25 : null}
    const buttonText = isUpdate ? 'OK' : 'ADD'
    return (
      <form className="ziltag-form-domain" onSubmit={handleSubmit}>
        <div className="ziltag-form-domain__title">{title}</div>
        {isUpdate ? <div className="ziltag-form-domain__url">{previousURL}</div> : null}
        {isUpdate ? <div className="ziltag-form-domain__arrow"/> : null}
        <div className="ziltag-form-domain__domain-fields" style={platformsStyle}>
          <DomainFields {...fields}/>
        </div>
        <div className="ziltag-form-domain__submit">
          <Button backgroundColor="#008BF3">{buttonText}</Button>
        </div>
      </form>
    )
  }
}