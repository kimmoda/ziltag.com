import {reduxForm} from 'redux-form'
import {bindActionCreators} from 'redux'
import {openDemo} from '../../actions/demo'
import Demo from '../../components/forms/Demo'

export default reduxForm({
  form: 'demo',
  fields: ['url']
}, null, mapDispatchToProps)(Demo)

function mapDispatchToProps(dispatch) {
  return bindActionCreators({
    onSubmit: demo
  }, dispatch)
}


function demo(params){
  const {url} = params
  return openDemo(url)
}
