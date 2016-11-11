import i18next from 'i18next'
import enUS from 'locales/en-US'
import zhTW from 'locales/zh-TW'

export default i18next.init({
  fallbackLng: 'en-US',
  initImmediate: false,
  debug: false,
  interpolation: {
    escapeValue: false, // not needed for react
  },
  resources: {
    'en-US': enUS,
    'zh-TW': zhTW
  }
})
