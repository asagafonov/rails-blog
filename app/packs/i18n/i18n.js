import { I18n } from 'i18n-js';

const i18n = new I18n({
  ru: {
    comments: {
      respond: 'Ответить',
      cancel: 'Отмена',
    },
  },
  en: {
    comments: {
      respond: 'Respond',
      cancel: 'Cancel',
    },
  },
});

i18n.defaultLocale = 'ru';
const currentLocale = window.location.pathname.includes('/en') ? 'en' : i18n.defaultLocale;
i18n.locale = currentLocale;

export default i18n;