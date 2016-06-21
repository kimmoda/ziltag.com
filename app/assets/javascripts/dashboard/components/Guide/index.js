import React from 'react'
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs'
import './index.scss'

export default props => (
  <div className="ziltag-guide">
    <div className="ziltag-guide__title">Installation guide</div>
    <div className="ziltag-guide__tabs">
      <Tabs>
        <TabList>
          <Tab>General</Tab>
          <Tab>Wordpress</Tab>
          <Tab>Blogger</Tab>
          <Tab>Tumblr</Tab>
        </TabList>
        <TabPanel>
          <ol className="ziltag-guide__list" >
            <li className="ziltag-guide__list-item" >Copy the script.</li>
            <li className="ziltag-guide__list-item" >Paste before <code>{'</body>'}</code> in your website.</li>
          </ol>
        </TabPanel>
        <TabPanel>
          <ol className="ziltag-guide__list" >
            <li className="ziltag-guide__list-item" >Go to <b>Administration Screens</b> > <b>Plugins</b> > <b>Add New</b>.</li>
            <li className="ziltag-guide__list-item" >Search for Ziltag app or upload the .zip file downloaded <a style={{color: '#008BF3'}} href="#">here</a>. Click Install Now.</li>
            <li className="ziltag-guide__list-item" >After the plugin is installed, click <b>Activate Plugin</b>.</li>
            <li className="ziltag-guide__list-item" >Select <b>Ziltag Widget</b> > <b>Account Setup</b>.</li>
            <li className="ziltag-guide__list-item" >Enter your Plugin Token as shown above. </li>
          </ol>
        </TabPanel>
        <TabPanel>
          <ol className="ziltag-guide__list">
            <li className="ziltag-guide__list-item">Go to <b>Blogger Dashboard</b> > <b>Template</b> > <b>Edit HTML</b>.</li>
            <li className="ziltag-guide__list-item">Paste the script before <code>{'</body>'}</code>.</li>
            <li className="ziltag-guide__list-item">Click <b>Save Template</b>.</li>
          </ol>
        </TabPanel>
        <TabPanel>
          <ol className="ziltag-guide__list">
            <li className="ziltag-guide__list-item">Click user icon on the top-right corner and select <b>Edit appearance</b>.</li>
            <li className="ziltag-guide__list-item">Click <b>Edit Theme</b> button under Website Theme tab.</li>
            <li className="ziltag-guide__list-item">Click <b>Edit HTML</b>.</li>
            <li className="ziltag-guide__list-item">Paste the script before <code>{'</body>'}</code>.</li>
            <li className="ziltag-guide__list-item">Click <b>Update Preview</b>, then <b>Save</b>. </li>
          </ol>
        </TabPanel>
      </Tabs>
    </div>
    <div className="ziltag-guide__video-button" onClick={props.onClickVideo}>Watch Tutorial Video</div>
    <div className="ziltag-guide__tips">
      Tips: Having trouble installing? Click the live chat button on bottom-right for 1-on-1 support.<br/>
      Wish to know more? Visit <a style={{color: 'inherit'}} href="https://ziltag.zendesk.com/" target="_blank">help</a> center.
    </div>
  </div>
)