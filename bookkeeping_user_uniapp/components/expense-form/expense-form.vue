<template>
	<view class="u-content">
		<u--form :model="form" :rules="rules" ref="uForm" labelWidth="auto">
			<u-form-item label="描述：" borderBottom>
				<u--input v-model="form.description" border="none"></u--input>
			</u-form-item>
			<u-form-item label="时间：" prop="createTime" borderBottom @click="openCreateTimePicker">
				<u--input v-model="createTime" disabled disabledColor="#ffffff" placeholder="请选择日期和时间" border="none"></u--input>
				<u-icon slot="right" name="arrow-right"></u-icon>
			</u-form-item>
			<u-form-item label="账户：" prop="accountId" borderBottom @click="openAccountSelect">
				<u--input v-model="accountName" disabled disabledColor="#ffffff" placeholder="请选择账户" border="none"></u--input>
				<u-icon slot="right" name="arrow-right"></u-icon>
			</u-form-item>
			<u-form-item label="分类：" borderBottom @click="openCategorySelect">
				<u--input v-model="categoryName" disabled disabledColor="#ffffff" placeholder="请选择分类" border="none"></u--input>
				<u-icon slot="right" name="arrow-right"></u-icon>
			</u-form-item>
			<template v-for="(item, index) in form.categories">
				<u-form-item borderBottom :label="item.categoryName+'：'">
					<u--input :value="item.amount" type="digit" border="none" placeholder="金额" @change="amountChange($event, item)"></u--input>
				</u-form-item>
				<u-form-item v-if="defaultCurrencyCode !== accountCurrencyCode" borderBottom :label="'折合' + defaultCurrencyCode +'：'">
					<u--input :value="item.convertedAmount" type="digit" border="none" placeholder="金额" @change="convertedAmountChange($event, item)"></u--input>
				</u-form-item>
			</template>
			<u-form-item label="交易对象：" borderBottom @click="openPayeeSelect">
				<u--input v-model="payeeName" disabled disabledColor="#ffffff" placeholder="请选择付款对象" border="none"></u--input>
				<u-icon slot="right" name="close" @click.native.stop="clearPayee" :stop="true"></u-icon>
			</u-form-item>
			<u-form-item label="标签：" borderBottom @click="openTagSelect">
				<u--input v-model="tagName" disabled disabledColor="#ffffff" placeholder="请选择标签" border="none"></u--input>
				<u-icon slot="right" name="close" @click.native.stop="clearTag" :stop="true"></u-icon>
			</u-form-item>
			<u-form-item v-if="type !== 2" label="是否确认：" borderBottom>
				<u-switch v-model="form.confirmed"></u-switch>
			</u-form-item>
			<u-form-item label="备注：" borderBottom>
				<u--input v-model="form.notes" border="none"></u--input>
			</u-form-item>
		</u--form>
		<u-button type="primary" @click="submit" text="保存" :customStyle="{marginTop: '15px'}"></u-button>
		<u-datetime-picker
			:show="showCreateTime"
			v-model="form.createTime"
			mode="datetime"
			closeOnClickOverlay
			@confirm="createTimeConfirm"
			@cancel="createTimeClose"
			@close="createTimeClose"
		></u-datetime-picker>
	</view>
</template>

<script>
import { saveExpense, updateExpense, refundExpense } from '@/config/api.js';
export default {
	
	data() {
		const flow = this.$store.getters['modelForm/model'];
		const type = this.$store.getters['modelForm/type'];
		let createTime = Number(new Date());
		if (type === 2) createTime = flow.createTime;
		return {
			type: type,
			form: {
				description: '',
				createTime: createTime,
				accountId: '',
				categories: [],
				payeeId: undefined,
				tags: [],
				confirmed: true,
				notes: '',
			},
			showCreateTime: false,
			createTime: uni.$u.timeFormat(new Date(), 'yyyy-mm-dd hh:MM'),
			accountName: '',
			accountCurrencyCode: '',
			categoryName: '',
			payeeName: undefined,
			tagName: '',
			rules: {
				'accountId': {
					type: 'number',
					required: true,
					message: '请选择交易账户',
					trigger: []
				}
			},
		};
	},
	computed: {
		defaultCurrencyCode() {
			return this.$store.getters.defaultCurrencyCode;
		}
	},
	methods: {
		initFormData() {
			const type = this.$store.getters['modelForm/type'];
			const flow = this.$store.getters['modelForm/model'];
			if (type === 1) {
				const defaultBook = this.$store.getters['defaultBook'];
				if (defaultBook) {
					if (defaultBook.defaultExpenseAccount) {
						this.accountName = defaultBook.defaultExpenseAccount.name;
						this.form.accountId = defaultBook.defaultExpenseAccount.id;
						this.accountCurrencyCode = defaultBook.defaultExpenseAccount.currencyCode;
					}
					if (defaultBook.defaultExpenseCategory) {
						this.categoryName = defaultBook.defaultExpenseCategory.name;
						this.form.categories = [{'categoryId': defaultBook.defaultExpenseCategory.id, 'categoryName': defaultBook.defaultExpenseCategory.name, 'amount': ''}]
					}
				}
			} else {
				this.form.description = flow.description;
				this.accountName = flow.accountName;
				this.accountCurrencyCode = flow.currencyCode;
				this.form.accountId = flow.accountId;
				this.categoryName = flow.categories.map(e => e.categoryName).join(', ');
				this.form.categories = flow.categories.map(e => {
					return {
						categoryId: e.categoryId,
					    categoryName: e.categoryName,
					    amount: type == 4 ? e.amount*-1 : e.amount,
					    convertedAmount: type == 4 ? e.convertedAmount*-1 : e.convertedAmount
					}
				});
				if (flow.payee) this.payeeName = flow.payee.name;
				if (flow.payee) this.form.payeeId = flow.payee.id;
				this.tagName = flow.tags.map(e => e.tagName).join(', ');
				this.form.tags = flow.tags.map(e => e.tagId);
				if (type === 2) {
					this.form.notes = flow.notes;
					this.createTime = uni.$u.timeFormat(new Date(flow.createTime), 'yyyy-mm-dd hh:MM');
					this.form.confirmed = flow.status === 1;
				}
			}
			// console.log(flow);
			//const flow = this.$store.getters.flow;
		},
		openCreateTimePicker() {
			this.showCreateTime = true;
			hideKeyboard();
		},
		createTimeClose() {
			this.showCreateTime = false
		},
		createTimeConfirm(e) {
			this.showCreateTime = false;
			this.createTime = uni.$u.timeFormat(e.value, 'yyyy-mm-dd hh:MM')
			//this.form.createTime = e.value.getTime();
		},
		openAccountSelect() {
			this.$store.commit('setSelectList', this.$store.getters.expenseableAccounts)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择账户&value=' + $this.form.accountId,
				events: {
					selectedValue(n) {
						$this.form.accountId = n;
						const account = $this.$store.getters.expenseableAccounts.find(e => e.id === n);
						$this.accountName = account.name;
						$this.accountCurrencyCode = account.currencyCode;
					}
				}
			});
		},
		openCategorySelect() {
			this.$store.commit('setSelectList', this.$store.getters.expenseCategories)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择类别&multiple=true&value=' + $this.form.categories.map(e => e.categoryId),
				events: {
					selectedValue(n) {
						let categoryList = [];
						n.forEach(i => {
							categoryList.push($this.$store.getters.expenseCategories.find(e => e.id === i));
						});
						$this.categoryName = categoryList.map(e => e.name).join(', ');
						$this.form.categories = categoryList.map(e => {return {'categoryId': e.id, 'categoryName': e.name, 'amount': ''}});
					}
				}
			});
		},
		openPayeeSelect() {
			this.$store.commit('setSelectList', this.$store.getters.expenseablePayees);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择交易对象&value=' + this.form.payeeId,
				events: {
					selectedValue(n) {
						that.form.payeeId = n;
						that.payeeName = that.$store.getters.expenseablePayees.find(e => e.id === n).name;
					}
				}
			});
		},
		clearPayee() {
			this.form.payeeId = undefined;
			this.payeeName = '';
		},
		openTagSelect() {
			this.$store.commit('setSelectList', this.$store.getters.expenseableTags)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择标签&multiple=true&value=' + $this.form.tags,
				events: {
					selectedValue(n) {
						let tagList = [];
						n.forEach(i => {
							if (!isNaN(i)) {
								tagList.push($this.$store.getters.expenseableTags.find(e => e.id === i));
							}
						});
						$this.tagName = tagList.map(e => e.name).join(', ');
						$this.form.tags = tagList.map(e => e.id);
					}
				}
			});
		},
		clearTag() {
			this.form.tags = [ ];
			this.tagName = '';
		},
		amountChange(value, item) {
			this.form.categories.find(e => e.categoryId === item.categoryId).amount = value;
		},
		convertedAmountChange(value, item) {
			this.form.categories.find(e => e.categoryId === item.categoryId).convertedAmount = value;
		},
		async submit() {
			try {
				await this.$refs.uForm.validate();
				const type = this.$store.getters['modelForm/type'];
				const flow = this.$store.getters['modelForm/model'];
				if (type === 1 || type === 3) {
					await saveExpense(this.form);
				} else if (type === 2) {
					await updateExpense(flow.id, this.form);
					this.$eventBus.$emit('flowUpdated');
				} else if (type === 4) {
					await refundExpense(flow.id, this.form)
				}
				uni.$u.toast('保存成功');
				this.$eventBus.$emit('flowsUpdated');
				uni.navigateBack();
			} catch (e) {
				console.log(e);
			}
		}
	},
	async mounted() {
		if (!this.$store.getters.expenseableAccounts) this.$store.dispatch('getExpenseableAccounts');
		if (!this.$store.getters.expenseCategories) this.$store.dispatch('getExpenseCategories');
		if (!this.$store.getters.expenseablePayees) this.$store.dispatch('getExpenseablePayees');
		if (!this.$store.getters.expenseableTags) this.$store.dispatch('getExpenseableTags');
		this.initFormData();
    	this.$refs.uForm.setRules(this.rules)
    },
};
</script>