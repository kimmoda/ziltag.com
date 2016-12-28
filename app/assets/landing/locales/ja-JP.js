export default {
  translation: {
    email_sent: 'メールが送信されました！',
    welcome_to_ziltag_demo: 'Ziltagの体験版へようこそ！申し訳ありませんが、現在この体験版はスマートフォンやタブレットでの実行ができません。Ziltagの体験版を利用したい方は、メールアドレスを教えてください。メールボックスに、デスクトップ環境のブラウザで実行される体験版のURLをお送り致します。ご協力いただき、ありがとうございます。',
    send_link: 'URLを送信する',
    start: 'はじめる',
    this_is_a_demo_applied_to: '*このページは、 Ziltagの体験版をサイト<b>{{url}}</b>に適用してなるものため、当サイトに含まれるコンテンツの全ての権利は、Ziltagに属するものではなく、当サイトの原作者に属します。技術的な困難があるため、Ziltagをサイトに適用する際、動作しない可能性はあります。質問や、技術的なサポートの要望などがあるの場合、サポート専用メールアドレスから<a href="mailto:hi@ziltag.com" target="_blank" rel="noopener">お問い合わせください</a>。',
    welcome_we_re_excited: 'Ziltagの体験版へようこそ！ここでは、Ziltagの楽しさを体験することができます。ボタンをクリックしてチュートリアルを始めましょう。',
    sign_out_function: '体験版ではログアウト機能が実装されてありません。',
    a_verification_email_has_been_sent: '認証メールがあなたのメールアドレスに送信されました。メールに表示するボタンをクリックし、アカウントの認証手続きをお進みください。',
    agree_terms_and_privacy: 'アカウント登録のボタンをクリックすることにより、<a href="http://blog.ziltag.com/terms" target="_blank" rel="noopener">利用規約</a>と<a href="http://blog.ziltag.com/privacy/" target="_blank" rel="noopener">プライバシー政策</a>に記載されたすべての内容を承諾の上で同意していただいたものとみなします。',
    already_have_an_account: 'アカウントをお持ちの方',
    blog: 'ブログ',
    find_anything: '画像の中に興味があるところにクリックすると、コメントを入力することができます。',
    write_anything: '投稿したい内容を入力してください。Postをクリックする（または cmd + enterを押す）と投稿することがます。Youtubeリンクをペーストすることで、リンク先の動画を表示することができます。',
    congratulation_you_have_learned: '🎉 おめでとうございます！チュートリアルはここで終了になります。体験版を使用し、Ziltagの新たな可能性をお探しください。また、アカウント登録すると、Ziltagをあなたのウェブサイトにインストールすることができるようになります。', // This is not directly translated from neither Chinese nor English. Please check the Japanese title with Google translation.
    click_the_z_button: '右上の赤いΖボタンをクリックする',
    dashboard: 'ダッシュボード',
    dead_simple_install: '手軽にインストール',
    demo: 'デモ',
    doc: 'ドキュメント',
    dont_have_an_account: 'アカウントをお持ちでない方',
    email: 'メールアドレス',
    forgot_password: 'パスワードを忘れた方',
    get_started_now: '今すぐ始める',
    home: 'ホームページ',
    hover_on_an_image: '画像にカーソルを合わせる。',
    join_now: '今すぐゲット',
    password: 'パスワード',
    please_enter_your_websites_url: 'URLを入力して下さい。（例：http://example.com）',
    please_enter_your_email: 'メールアドレスを入力して下さい。',
    preview_on_your_website: 'プレビュー', // I'd like to know what time to use this sentence, if possible.
    privacy: 'プライバシー政策',
    send: '送信する',
    share: 'シェア',
    sign_in: 'ログイン',
    sign_up: 'アカウント登録',
    spread_the_word: 'Ziltagを友たちにシェアする！',
    step: '手順',
    subtitle: '素晴らしい画像にコメントを！', // source:この素晴らしい世界に祝福を！ This is not directly translated from neither Chinese nor English. Please check the Japanese title with Google translation.
    suggest_new_features: '機能追加の要望',
    support: 'お問い合わせ',
    tell_your_friends: '',
    terms: '利用規約',
    thanks_for_signing_up: 'アカウント登録にお申し込みいただき、ありがとうございます！',
    tip: 'ヒント',
    title: '画像をBBSにする、Ziltag', // This is not directly translated from neither Chinese nor English. Please check the Japanese title with Google translation.
    url: 'ウェブサイトのURL（例：https://example.com）',
    username_or_email: 'ユーザー名またはメールアドレス',
    username: 'ユーザー名',
    watch_video: 'PVを観る',
    we_will_send_you_a_password_reset_instruction: 'パスワード再設定のお手続きに関するメールが送信されます。',
    doc_body: `<h1>プラグインコンフィギュレーション</h1>
    <h2>属性</h2>
    <h3>プラグインを無効にする</h3>
    <p>特定の画像でZiltagを無効にするには、画像の属性<code>img</code> に <code>data-ziltag=&quot;false&quot;</code> を付け加える必要があります。</p>
    <p><code>&lt;img src=&quot;...src&quot; data-ziltag=&quot;false&quot;/&gt;</code></p>
    <h3>自動再生</h3>
    <p>画像にカーソルを合わせなくてもZiltagも表示されるようになります。</p>
    <p><code>&lt;img src=&quot;...src&quot; data-ziltag-autoplay=&quot;true|false&quot;/&gt;</code></p>
    <p>デフォルト： <code>true</code></p>
    <h3>スイッチを表示する</h3>
    <p>画像の右上にあるZiltag の表示に関するスイッチを表示する。</p>
    <p><code>&lt;img src=&quot;...src&quot; data-ziltag-switch=&quot;true|false&quot;/&gt;</code></p>
    <p>デフォルト： <code>true</code></p>
    <h2>制限事項</h2>
    <p>画像のサイズ、横幅の最低限は<code>200px</code>で、且つ高さの最低限は <code>100px</code>です。</p>`
  }
}
