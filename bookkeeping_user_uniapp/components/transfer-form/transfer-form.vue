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
			<u-form-item label="转出账户：" prop="fromId" borderBottom @click="openFromAccountSelect">
				<u--input v-model="fromAccountName" disabled disabledColor="#ffffff" placeholder="请选择账户" border="none"></u--input>
				<u-icon slot="right" name="arrow-right"></u-icon>
			</u-form-item>
			<u-form-item label="转入账户：" prop="toId" borderBottom @click="openToAccountSelect">
				<u--input v-model="toAccountName" disabled disabledColor="#ffffff" placeholder="请选择账户" border="none"></u--input>
				<u-icon slot="right" name="arrow-right"></u-icon>
			</u-form-item>
			<u-form-item label="金额：" prop="amount" borderBottom>
				<u--input v-model="form.amount" border="none"></u--input>
			</u-form-item>
			<u-form-item v-if="needConvert" :label="'折合' + toAccountCurrencyCode +'：'" prop="convertedAmount" borderBottom>
				<u--input v-model="form.convertedAmount" border="none"></u--input>
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
import { saveTransfer, updateTransfer } from '@/config/api.js';
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
				fromId: '',
				toId: '',
				amount: undefined,
				convertedAmount: undefined,
				tags: [],
				confirmed: true,
				notes: '',
			},
			showCreateTime: false,
			createTime: uni.$u.timeFormat(new Date(), 'yyyy-mm-dd hh:MM'),
			fromAccountName: '',
			fromAccountCurrencyCode: undefined,
			toAccountName: '',
			toAccountCurrencyCode: undefined,
			tagName: '',
			rules: {
				'fromId': {
					type: 'number',
					required: true,
					message: '请选择转出账户',
					trigger: []
				},
				'toId': {
					type: 'number',
					required: true,
					message: '请选择转入账户',
					trigger: []
				},
				'amount': {
					type: 'number',
					required: true,
					message: '请输入金额',
					trigger: ['blur', 'change']
				},
				'convertedAmount': {
					type: 'number',
					required: true,
					message: '请输入金额',
					trigger: ['blur', 'change']
				}
			},
		};
	},
	computed: {
		needConvert() {
			const type = this.$store.getters['modelForm/type'];
			const flow = this.$store.getters['modelForm/model'];
			if (type === 3) return flow.needConvert; //复制的时候
			if (this.fromAccountCurrencyCode && this.toAccountCurrencyCode) {
				if (this.fromAccountCurrencyCode !== this.toAccountCurrencyCode) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	},
	methods: {
		initFormData() {
			const type = this.$store.getters['modelForm/type'];
			const flow = this.$store.getters['modelForm/model'];
			if (type === 1) {
				const defaultBook = this.$store.getters['defaultBook'];
				if (defaultBook) {
					if (defaultBook.defaultTransferFromAccount) {
						this.fromAccountName = defaultBook.defaultTransferFromAccount.name;
						this.fromAccountCurrencyCode = defaultBook.defaultTransferFromAccount.currencyCode;
						this.form.fromId = defaultBook.defaultTransferFromAccount.id;
					}
					if (defaultBook.defaultTransferToAccount) {
						this.toAccountName = defaultBook.defaultTransferToAccount.name;
						this.toAccountCurrencyCode = defaultBook.defaultTransferFromAccount.currencyCode;
						this.form.toId = defaultBook.defaultTransferToAccount.id;
					}
				}
			} else {
				this.form.description = flow.description;
				this.fromAccountName = flow.fromAccountName;
				this.fromAccountCurrencyCode = flow.currencyCode;
				this.form.fromId = flow.accountId;
				this.toAccountName = flow.toAccountName;
				this.toAccountCurrencyCode = flow.toCurrencyCode;
				this.form.toId = flow.toId;
				this.form.amount = flow.amount;
				this.form.convertedAmount = flow.convertedAmount;
				this.tagName = flow.tags.map(e => e.tagName).join(', ');
				this.form.tags = flow.tags.map(e => e.tagId);
				if (type === 2) {
					console.log(flow)
					this.form.notes = flow.notes;
					this.createTime = uni.$u.timeFormat(new Date(flow.createTime), 'yyyy-mm-dd hh:MM');
					this.form.confirmed = flow.status === 1;
				}
			}
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
		},
		openFromAccountSelect() {
			this.$store.commit('setSelectList', this.$store.getters.transferFromAbleAccounts)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择账户&value=' + $this.form.fromId,
				events: {
					selectedValue(n) {
						$this.form.fromId = n;
						const account = $this.$store.getters.transferFromAbleAccounts.find(e => e.id === n);
						$this.fromAccountName = account.name;
						$this.fromAccountCurrencyCode = account.currencyCode;
					}
				}
			});
		},
		openToAccountSelect() {
			this.$store.commit('setSelectList', this.$store.getters.transferToAbleAccounts)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择账户&value=' + $this.form.toId,
				events: {
					selectedValue(n) {
						$this.form.toId = n;
						const account = $this.$store.getters.transferToAbleAccounts.find(e => e.id === n);
						$this.toAccountName = account.name;
						$this.toAccountCurrencyCode = account.currencyCode;
					}
				}
			});
		},
		openTagSelect() {
			this.$store.commit('setSelectList', this.$store.getters.transferableTags)
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择标签&multiple=true&value=' + $this.form.tags,
				events: {
					selectedValue(n) {
						let tagList = [];
						n.forEach(i => {
							if (!isNaN(i)) {
								tagList.push($this.$store.getters.transferableTags.find(e => e.id === i));
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
		async submit() {
			try {
				await this.$refs.uForm.validate();
				const type = this.$store.getters['modelForm/type'];
				const flow = this.$store.getters['modelForm/model'];
				if (type === 1 || type === 3) {
					await saveTransfer(this.form);
				} else if (type === 2) {
					await updateTransfer(flow.id, this.form);
					this.$eventBus.$emit('flowUpdated');
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
		if (!this.$store.getters.transferFromAbleAccounts) this.$store.dispatch('getTransferFromAbleAccounts');
		if (!this.$store.getters.transferToAbleAccounts) this.$store.dispatch('getTransferToAbleAccounts');
		if (!this.$store.getters.transferableTags) this.$store.dispatch('getTransferableTags');
		this.initFormData();
    	this.$refs.uForm.setRules(this.rules)
    },
};
</script>