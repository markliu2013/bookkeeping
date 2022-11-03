<template>
	<view class="u-page">
		<view v-if="!loading" class="u-content">
			<u-row customStyle="margin-bottom: 10px"></u-row>
			<u-row customStyle="margin-bottom: 10px">
				<u-button type="primary" text="修改" size="mini" customStyle="margin-right: 5px" @click="updateAccount"></u-button>
				<u-button type="primary" text="禁用" size="mini" customStyle="margin-right: 5px"></u-button>
				<u-button type="primary" text="删除" size="mini" @click="showDeleteModal = true"></u-button>
			</u-row>
			<u-row customStyle="margin-bottom: 10px">账户类型：{{account.typeName}}</u-row>
			<u-row customStyle="margin-bottom: 10px">账户名称：{{account.name}}</u-row>
			<u-row customStyle="margin-bottom: 10px">
				余额：{{account.balance}}<u--text @click="adjustBalance" type="primary" customStyle="margin-left: 10px" text="余额调整"></u--text>
			</u-row>
			<u-row customStyle="margin-bottom: 10px">币种：{{account.currencyCode}}</u-row>
			<u-row v-if="account.currencyCode !== defaultCurrencyCode" customStyle="margin-bottom: 10px">
				折合{{defaultCurrencyCode}}：{{account.convertedBalance}}
			</u-row>
			<u-row v-if="account.type === 2" customStyle="margin-bottom: 10px">信用额度：{{account.limit}}</u-row>
			<u-row v-if="account.type === 2" customStyle="margin-bottom: 10px">剩余额度：{{account.remainLimit}}</u-row>
			<u-row v-if="account.type === 2" customStyle="margin-bottom: 10px">账单日：{{account.billDay}}</u-row>
			<u-row v-if="account.type === 3" customStyle="margin-bottom: 10px">年化利率：{{account.apr}}</u-row>
			<u-row v-if="account.type === 4" customStyle="margin-bottom: 10px">更新日期：{{account.asOfDate}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否可用：{{account.enable ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否计入净资产：{{account.include ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否可支出：{{account.expenseable ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否可收入：{{account.incomeable ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否可转入：{{account.transferToAble ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">是否可转出：{{account.transferFromAble ? '是' : '否'}}</u-row>
			<u-row customStyle="margin-bottom: 10px">初始余额：{{account.initialBalance}}</u-row>
			<u-row customStyle="margin-bottom: 10px">备注：{{account.notes}}</u-row>
			<u-row customStyle="margin-bottom: 10px">卡号：{{account.no}} <u--text v-if="account.no" @click="copyNo" type="primary" customStyle="margin-left: 10px" text="复制卡号"></u--text></u-row>
		</view>
		<u-loading-page :loading="loading"></u-loading-page>
		<u-modal
			content="删除后无法恢复，确认此操作吗？"
			:show="showDeleteModal"
			showCancelButton
			closeOnClickOverlay
			@confirm="deleteHandler"
			@cancel="showDeleteModal = false"
			@close="showDeleteModal = false"
		></u-modal>
	</view>
</template>

<script>
import { getAccountById, deleteAccountById } from '@/config/api.js';

export default {
	data() {
		return {
			id: undefined,
			account: undefined,
			loading: true,
			showDeleteModal: false,
			deleteLoading: false,
		}
	},
	computed: {
		defaultCurrencyCode() {
			return this.$store.getters.defaultCurrencyCode;
		}
	},
	methods: {
		async deleteHandler() {
			this.deleteLoading = true;
			try {
				await deleteAccountById(this.account.id);
				uni.$u.toast('操作成功');
				const eventChannel = this.getOpenerEventChannel();
				eventChannel.emit('deleteSuccess');
				uni.navigateBack();
				this.deleteLoading = false;
			} catch(e) {
				this.deleteLoading = false;
				console.log(e);
			}
		},
		async refresh() {
			this.loading = true;
			try{
				this.account = await getAccountById(this.id);
				this.loading = false;
			}catch(e){
				//TODO handle the exception
				this.loading = false;
				console.log(e);
			}
		},
		updateAccount() {
			var $this = this;
			uni.navigateTo({
				url: '/pages/account-form/account-form',
				success: function(res) {
					$this.$store.commit('modelForm/setType', 2);
					$this.$store.commit('modelForm/setFlow', $this.account);
			    }
			});
		},
		copyNo() {
			console.log(34);
			uni.setClipboardData({
				data: this.account.no,
				success: () => {
					uni.showToast({ //提示
						title: '复制成功'
					})
				}
			});
		},
		adjustBalance() {
			
		}
	},
	async onLoad(option) {
		this.id = option.id;
		this.refresh();
		var $this = this;
		this.$eventBus.$on('flowUpdated', function() {
			$this.refresh();
		});
	},
}
</script>

<style>

</style>
