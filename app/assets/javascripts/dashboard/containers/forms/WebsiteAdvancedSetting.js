import WebsiteAdvancedSetting from '../../components/forms/WebsiteAdvancedSetting'
import { connect } from 'react-redux'
import {requestUpdateWebsitePermission} from 'actions'

export default connect(
  state => ({
    id: state.dialog.payload.id,
    restricted: state.dialog.payload.restricted,
  }),
  dispatch => ({
    onToggle: (id, restricted) => dispatch(requestUpdateWebsitePermission(id, restricted)),
  }),
  (stateProps, dispatchProps, ownProps) => Object.assign(
    {}, ownProps, stateProps, dispatchProps, {
      onToggle: event => dispatchProps.onToggle(stateProps.id, !event.target.checked)
    }
  )
)(WebsiteAdvancedSetting)
