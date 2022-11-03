import t from '@/utils/translate'

export const requiredRules = () => [
  {
    required: true,
    message: t('rules.required')
  }
];

export const userNameRules = () => [
  {
    required: true,
    message: t('rules.userName.required'),
  },
  {
    pattern: "^[A-Za-z0-9]{1,16}$",
    message: t('rules.userName.pattern'),
  }
];

export const passwordRules = () => [
  {
    required: true,
    message: t('rules.password.required'),
  },
  {
    pattern: "^[A-Za-z0-9~`!@#\\$%\\^&\\*\\(\\)-_=\\+\\[\\]\\{\\}\\|]{6,32}$",
    message: t('rules.password.pattern'),
  }
];

export const emailRules = () => [
  {
    type: "email",
    message: t('rules.email.pattern'),
  }
];

// 账户名，类别名，标签名等。
export const nameRules = () => [
  {
    required: true,
    message: t('rules.name.required'),
  },
  {
    max: 16,
    message: t('rules.name.pattern'),
  }
];

export const balanceRequiredRules = () => [
  {
    required: true,
    message: t('rules.balance.required'),
  },
  {
    pattern: "^-?\\d{1,9}(\\.\\d{0,2})?$",
    message: t('rules.balance.pattern'),
  }
];

export const amountRequiredRules = () => [
  {
    required: true,
    message: t('rules.amount.required'),
  },
  {
    pattern: "^-?\\d{1,9}(\\.\\d{0,2})?$", //可以负数，代表退款
    message: t('rules.amount.pattern'),
  }
];

export const amountRequiredRulesPositive = () => [
  {
    required: true,
    message: t('rules.amount.required'),
  },
  {
    pattern: "^\\d{1,9}(\\.\\d{0,2})?$",
    message: t('rules.amount.pattern'),
  }
];

export const balanceRules = () => [
  {
    pattern: "^-?\\d{1,9}(\\.\\d{0,2})?$",
    message: t('rules.balance.pattern'),
  }
];

export const descriptionRules = () => [
  {
    max: 16,
    message: t('rules.description.pattern'),
  }
];

export const notesRules = () => [
  {
    max: 1024,
    message: t('rules.notes.pattern'),
  }
];

export const timeRequiredRules = () => [
  {
    type: 'object',
    required: true,
    message: t('rules.time.required')
  }
];

export const timeRangeRequiredRules = () => [
  {
    type: 'array',
    required: true,
    message: t('rules.time.required')
  }
];

export const categoryRequiredRules = () => [
  {
    required: true,
    message: t('rules.category.required')
  }
];

export const accountRequiredRules = () => [
  {
    required: true,
    message: t('rules.account.required')
  }
];

export const limitRequiredRules = () => [
  {
    required: true,
    message: t('rules.limit.required'),
  },
  {
    pattern: "^\\d{1,9}(\\.\\d{0,2})?$",
    message: t('rules.limit.pattern'),
  }
];

export const aprRules = () => [
  {
    pattern: "^\\d{1,3}(\\.\\d{0,2})?$",
    message: t('rules.apr.pattern'),
  }
];
