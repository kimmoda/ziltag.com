import React from 'react'
import Highlight from 'highlight.js'
import './index.css'

const script = `<script
  src="https://ziltag.com/plugin.js"
  data-ziltag="YOUR_TOKEN">
</script>`

export default () => (
  <div className="m-verified">
    <div className="m-verified__logo"/>
    <div className="m-verified__title">Account verified.</div>
    <div className="m-verified__subtitle">Here is the installation guide.</div>
    <div className="m-verified__note">**Note: You may only access your dashboard by web browser to manage your account.</div>
    <hr style={{marginTop: 12, width: '100%', borderTopColor: '#979797', borderBottom: 'none'}}/>
    <h1>INSTALLATION GUIDE</h1>
    <p>This guide helps you to install Ziltag Plugin on your website/ blog. You need to have administrative permission to edit your HTML codes. If you do not have the permission, please contact your web administrator.</p>
    <p>To get started, you need to have your script ready. You can find your script in our verification email and your account page:</p>
    <pre className="hljs html" dangerouslySetInnerHTML={{__html: Highlight.highlight('html', script).value}}/>
    <p>The script can only work on the domain that you signed up, please be careful of the domain settings. You can edit your domain settings in your account page.</p>
    <p>Once you have the script, just copy and paste it in your website HTML. We recommend to paste the script either inside <b>&lt;head&gt;&lt;/head&gt;</b> or <b>&lt;body&gt;&lt;/body&gt;</b></p>
    <h2>SELF-HOSTED WEBSITE</h2>
    <ol>
      <li>Copy the script.</li>
      <li>Paste it in website HTML.</li>
    </ol>
    <h2>WORDPRESS</h2>
    <ol>
      <li>Go to Administration Screens > Plugins > Add New.</li>
      <li>Download our Wordpress plugin <a href="https://github.com/ziltag/ziltag-wp/releases/latest" target="_blank" rel="noopener noreferrer">here</a> and click <b>Upload Plugin</b>. After uploading the file, click <b>Install Now</b>.</li>
      <li>After the plugin is installed, go back to your plugin page and find Ziltag Plugin. Click <b>Activate</b>.</li>
      <li>Click <b>Settings</b> and enter your Plugin Token.</li>
      <li>Click <b>Save Changes</b>.</li>
    </ol>
    <h2>TUMBLR</h2>
    <ol>
      <li>Click user icon on the top-right corner and select <b>Edit appearance</b>.</li>
      <li>Click <b>Edit Theme</b> under Website Theme tab.</li>
      <li>Click <b>Edit HTML</b>.</li>
      <li>Paste the script either inside <b>&lt;head&gt;&lt;/head&gt;</b> or <b>&lt;body&gt;&lt;/body&gt;</b></li>
      <li>Click <b>Update Preview</b>, then <b>Save</b>.</li>
    </ol>
    <h2>BLOGGER</h2>
    <ol>
      <li>Visit the dashboard of your Blogger blog.</li>
      <li>Select <b>Template</b> on the side bar.</li>
      <li>Click <b>Edit HTML</b>.</li>
      <li>Paste the script either inside <b>&lt;head&gt;&lt;/head&gt;</b> or <b>&lt;body&gt;&lt;/body&gt;</b></li>
      <li>Click <b>Save template</b>, then <b>Save</b>.</li>
    </ol>
    <h2>GHOST</h2>
    <ol>
      <li>Visit the dashboard of your Ghost blog.</li>
      <li>Go to <b>Settings > Code Injection</b></li>
      <li>Paste the script either in the Blog Header or Blog Footer area.</li>
    </ol>
    <h2>OTHERS</h2>
    <p>Please <a href="mailto:hi@ziltag.com">contact us</a> if your platform is not supported.</p>
  </div>
)
