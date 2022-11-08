const http = uni.$u.http

export const signin = (params) => http.post('signin', params)

export const getSession = () => http.get('session')

export const queryFlows = (params) => http.get('flows', { params: params })

export const getFlowById = (id) => http.get('flows/' + id);

export const deleteFlowById = (id) => http.delete('flows/' + id)

export const confirmFlow = (id) => http.put('flows/' + id + '/confirm')

export const saveExpense = (params) => http.post('expenses', params)

export const updateExpense = (id, params) => http.put('expenses/' + id, params)

export const refundExpense = (id, params) => http.post('expenses/' + id + '/refund' , params)

export const saveIncome = (params) => http.post('incomes', params)

export const updateIncome = (id, params) => http.put('incomes/' + id, params)

export const refundIncome = (id, params) => http.post('incomes/' + id + '/refund' , params)

export const saveTransfer = (params) => http.post('transfers', params)

export const updateTransfer = (id, params) => http.put('transfers/' + id, params)

export const getEnableAccounts = () => http.get('accounts/enable')

export const getExpenseableAccounts = () => http.get('accounts/expenseable')

export const getIncomeableAccounts = () => http.get('accounts/incomeable')

export const getTransferFromAbleAccounts = () => http.get('accounts/transfer-from-able')

export const getTransferToAbleAccounts = () => http.get('accounts/transfer-to-able')

export const getExpenseCategories = () => http.get('expense-categories/enable');

export const getIncomeCategories = () => http.get('income-categories/enable');

export const getExpenseablePayees = () => http.get('payees/expenseable')

export const getIncomeablePayees = () => http.get('payees/incomeable')

export const getEnablePayees = () => http.get('payees/enable')

export const getExpenseableTags = () => http.get('tags/expenseable')

export const getIncomeableTags = () => http.get('tags/incomeable')

export const getTransferableTags = () => http.get('tags/transferable')

export const getEnableTags = () => http.get('tags/enable')

export const queryAccounts = (type, params) => {
	if (type === 1) {
		return http.get('checking-accounts', { params: params });
	} else if (type === 2) {
		return http.get('credit-accounts', { params: params });
	} else if (type === 3) {
		return http.get('debt-accounts', { params: params });
	} else if (type === 4) {
		return http.get('asset-accounts', { params: params });
	}
}

export const getAccountById = (id) => http.get('accounts/' + id);

export const deleteAccountById = (id) => http.delete('accounts/' + id);

export const queryBooks = (params) => http.get('books', { params: params });

export const setDefaultBook = (id) => http.put('setDefaultBook/' + id);

export const reportExpenseCategory = (params) => http.get('reports/expense-category', { params: params });

export const reportIncomeCategory = (params) => http.get('reports/income-category', { params: params });

export const reportDebt = (params) => http.get('reports/debt', { params: params });

export const reportAsset = (params) => http.get('reports/asset', { params: params });