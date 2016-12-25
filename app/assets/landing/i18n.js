import i18next from 'i18next'
import enUS from 'locales/en-US'
import zhTW from 'locales/zh-TW'
import jaJP from 'locales/ja-JP'

export default i18next.init({
  fallbackLng: {
    ja: ['ja-JP'],
    zh: ['zh-TW'],
    en: ['en-US'],
    default: ['en-US']
  },
  initImmediate: false,
  debug: false,
  interpolation: {
    escapeValue: false, // not needed for react
  },
  resources: {
    'en-US': enUS,
    'zh-TW': zhTW,
    'ja-JP': jaJP
  }
})
