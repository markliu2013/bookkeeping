<template>
	<view class="u-page">
		<view v-if="!loading" class="u-content">
			<u-row customStyle="margin-bottom: 10px"></u-row>
			<u-row customStyle="margin-bottom: 10px">
				<u-button type="primary" text="复制" size="mini" customStyle="margin-right: 5px" @click="copyFlow"></u-button>
				<u-button type="primary" text="修改" size="mini" customStyle="margin-right: 5px" @click="updateFlow"></u-button>
				<u-button type="primary" :disabled="refundDisabled" text="退款" size="mini" customStyle="margin-right: 5px" @click="refundFlow"></u-button>
				<u-button type="primary" :disabled="flow.status != 2" text="确认" size="mini" customStyle="margin-right: 5px" @click="showConfirmModal = true"></u-button>
				<u-button type="primary" text="图片" size="mini" customStyle="margin-right: 5px"></u-button>
				<u-button type="primary" text="删除" size="mini" @click="showDeleteModal = true"></u-button>
			</u-row>
			<u-row customStyle="margin-bottom: 10px">描述：{{flow.description}}</u-row>
			<u-row customStyle="margin-bottom: 10px">交易类型：{{flow.typeName}}</u-row>
			<u-row customStyle="margin-bottom: 10px">时间：{{flow.createTimeFormatted}}</u-row>
			<u-row customStyle="margin-bottom: 10px">金额：{{flow.amount}}</u-row>
			<u-row v-if="flow.needConvert" customStyle="margin-bottom: 10px">折合{{flow.toCurrencyCode}}：{{flow.convertedAmount}}</u-row>
			<u-row customStyle="margin-bottom: 10px">账户：{{flow.accountName}}</u-row>
			<u-row v-if="flow.type === 1 || flow.type === 2" customStyle="margin-bottom: 10px">类别：{{flow.categoryName}}</u-row>
			<u-row v-if="flow.type !== 4" customStyle="margin-bottom: 10px">标签：{{flow.tagsName}}</u-row>
			<u-row v-if="flow.type === 1 || flow.type === 2" customStyle="margin-bottom: 10px">交易对象：{{flow.payee ? flow.payee.name : ''}}</u-row>
			<u-row customStyle="margin-bottom: 10px">状态：{{flow.statusName}}</u-row>
			<u-row customStyle="margin-bottom: 10px">备注：{{flow.notes}}</u-row>
		</view>
		<u-loading-page :loading="loading"></u-loading-page>
		<u-modal
			content="删除账单会撤回对应账户余额变动且无法恢复，确认此操作吗？"
			:show="showDeleteModal"
			showCancelButton
			closeOnClickOverlay
			@confirm="deleteHandler"
			@cancel="showDeleteModal = false"
			@close="showDeleteModal = false"
		></u-modal>
		<u-modal
			content="将更改对应账号余额，确认此操作吗？"
			:show="showConfirmModal"
			showCancelButton
			closeOnClickOverlay
			@confirm="confirmHandler"
			@cancel="showConfirmModal = false"
			@close="showConfirmModal = false"
		></u-modal>
	</view>
</template>

<script>
import { getFlowById, deleteFlowById, confirmFlow } from '@/config/api.js';

export default {
	data() {
		return {
			id: undefined,
			flow: undefined,
			loading: true,
			showDeleteModal: false,
			deleteLoading: false,
			showConfirmModal: false,
			confirmLoading: false,
		}
	},
	computed: {
		refundDisabled() {
			return !((this.flow.type === 1 || this.flow.type === 2) && (this.flow.status !== 2 && this.flow.amount > 0));
		},
		defaultCurrencyCode() {
			return this.$store.getters.defaultCurrencyCode;
		}
	},
	methods: {
		async deleteHandler() {
			this.deleteLoading = true;
			try {
				await deleteFlowById(this.flow.id);
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
		async confirmHandler() {
			this.confirmLoading = true;
			try {
				await confirmFlow(this.flow.id);
				this.showConfirmModal = false;
				uni.$u.toast('操作成功');
				this.confirmLoading = false;
				this.refresh();
			} catch(e) {
				this.confirmLoading = false;
				console.log(e);
			}
		},
		async refresh() {
			this.loading = true;
			try{
				this.flow = await getFlowById(this.id);
				this.loading = false;
			}catch(e){
				//TODO handle the exception
				this.loading = false;
				console.log(e);
			}
		},
		copyFlow() {
			this.$store.commit('modelForm/setType', 3);
			this.$store.commit('modelForm/setModel', this.flow);
			uni.navigateTo({ url: '/pages/flow-form/flow-form' });
		},
		updateFlow() {
			this.$store.commit('modelForm/setType', 2);
			this.$store.commit('modelForm/setModel', this.flow);
			uni.navigateTo({ url: '/pages/flow-form/flow-form' });
		},
		refundFlow() {
			this.$store.commit('modelForm/setType', 4);
			this.$store.commit('modelForm/setModel', this.flow);
			uni.navigateTo({ url: '/pages/flow-form/flow-form' });
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
