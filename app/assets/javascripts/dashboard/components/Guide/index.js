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
            <li className="ziltag-guide__list-item">Copy the script.</li>
            <li className="ziltag-guide__list-item">Paste before <code>{'</body>'}</code> in your website.</li>
          </ol>
        </TabPanel>
        <TabPanel>
          <ol className="ziltag-guide__list" >
            <li className="ziltag-guide__list-item">Go to <b>Administration Screens</b> > <b>Plugins</b> > <b>Add New</b>.</li>
            <li className="ziltag-guide__list-item">Download the <a style={{color: '#008BF3'}} href="//github.com/ziltag/ziltag-wp/releases/latest" target="_blank">plugin</a> and click <b>Upload Plugin</b>. After uploading the file, click <b>Install Now</b>.</li>
            <li className="ziltag-guide__list-item">When installed, go back to <b>Administration Screens</b> > <b>Plugins</b>. Find Ziltag Plugin and click <b>Activate</b>.</li>
            <li className="ziltag-guide__list-item">Click <b>Settings</b> and enter your Token.</li>
            <li className="ziltag-guide__list-item">Click <b>Save Changes</b>.</li>
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
      Wish to know more? Visit <a style={{color: 'inherit'}} href="//ziltag.zendesk.com/" target="_blank">help</a> center.
    </div>
  </div>
)
