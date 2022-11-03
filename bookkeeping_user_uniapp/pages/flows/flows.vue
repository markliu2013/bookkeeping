<template>
	<view class="u-page">
		<u-navbar
			:safeAreaInsetTop="true"
			:placeholder="true"
			:border="true"
			:fixed="true"
			leftIcon="reload"
			leftIconSize="25px"
			@leftClick="refreshData"
		>
			<view class="u-nav-slot" slot="right">
				<u-icon name="list" size="25" @click="showSortAction"></u-icon>
				<u-icon name="search" size="25" @click="showSearchModal"></u-icon>
			</view>
		</u-navbar>
		<uni-list :border="false">
			<uni-list-item v-for="(item, index) in flows" :key="index" clickable
				:class="{'expense': item.type === 1, 'income': item.type === 2}"
				:title="item.title"
				:rightText="item.amountFormatted"
				:note="item.subTitle"
				link @click="itemClick(item)">
			</uni-list-item>
		</uni-list>
		<u-loadmore v-if="status !== 'empty'" :status="status" :loadmoreText="loadmoreText" />
		<u-loading-page :loading="loading"></u-loading-page>
		<u-empty mode="search" v-if="status === 'empty'"></u-empty>
		<tab-bar :selectedIndex="1"></tab-bar>
		<u-action-sheet
			:actions="sortList"
			:show="showSortList"
			:closeOnClickOverlay="true"
			@select="sortItemClick"
			@close="closeSortAction">
		</u-action-sheet>
		<u-popup
			:show="showSearchPopup"
			mode="top"
			:closeOnClickOverlay="true"
			:safeAreaInsetTop="true"
			@close="closeSearchPopup"
		>
			<view class="query-form">
				<u--form :model="queryParams" labelWidth="auto">
					<u-form-item label="描述：" borderBottom>
						<u--input v-model="queryParams.description" border="none"></u--input>
					</u-form-item>
					<u-form-item label="开始时间：" borderBottom>
						<uni-datetime-picker v-model="queryParams.minTime" type="date" :border="false" return-type="timestamp" />
					</u-form-item>
					<u-form-item label="结束时间：" borderBottom>
						<uni-datetime-picker v-model="queryParams.maxTime" type="date" :border="false" return-type="timestamp" />
					</u-form-item>
					<u-form-item label="交易对象：" borderBottom @click="openPayeeSelect">
						<u--input v-model="queryParamsLabel.payeeName" disabled disabledColor="#ffffff" placeholder="请选择交易对象" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="交易标签：" borderBottom @click="openTagSelect">
						<u--input v-model="queryParamsLabel.tagName" disabled disabledColor="#ffffff" placeholder="请选择标签" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="支出分类：" borderBottom @click="openExpenseCategorySelect">
						<u--input v-model="queryParamsLabel.expenseCategoryName" disabled disabledColor="#ffffff" placeholder="请选择支出分类" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="收入分类：" borderBottom @click="openIncomeCategorySelect">
						<u--input v-model="queryParamsLabel.incomeCategoryName" disabled disabledColor="#ffffff" placeholder="请选择收入分类" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="交易类型：" borderBottom @click="openFlowTypeSelect">
						<u--input v-model="queryParamsLabel.typeName" disabled disabledColor="#ffffff" placeholder="请选择类型" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="交易账户：" borderBottom @click="openAccountSelect">
						<u--input v-model="queryParamsLabel.accountName" disabled disabledColor="#ffffff" placeholder="请选择账户" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
					<u-form-item label="交易状态：" borderBottom @click="openFlowStatusSelect">
						<u--input v-model="queryParamsLabel.statusName" disabled disabledColor="#ffffff" placeholder="请选择状态" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
				</u--form>
				<u-button type="primary" @click="queryFlowsSubmit" text="查询" :customStyle="{marginTop: '15px'}"></u-button>
				<u-button type="primary" @click="queryFlowsReset" text="重置" :customStyle="{marginTop: '15px'}"></u-button>
				<u-button @click="closeSearchPopup" text="关闭" :customStyle="{marginTop: '15px'}"></u-button>
				<u-picker
					:show="flowTypeSearchShow"
					:columns="flowTypes"
					keyName="label"
					@confirm="confirmFlowType"
					@close="closeFlowType"
					@cancel="closeFlowType"
					:closeOnClickOverlay=true
				></u-picker>
				<u-picker
					:show="statusSearchShow"
					:columns="flowStatus"
					keyName="label"
					@confirm="confirmFlowStatus"
					@close="closeFlowStatus"
					@cancel="closeFlowStatus"
					:closeOnClickOverlay=true
				></u-picker>
			</view>
		</u-popup>
	</view>
</template>

<script>
import { queryFlows } from '@/config/api.js';
export default {
	data() {
		return {
			flows: [ ],
			queryParams: {
				description: undefined,
				minTime: undefined,
				maxTime: undefined,
				payees: undefined,
				tags: undefined,
				categories: undefined,
				type: undefined,
				accountId: undefined,
				status: undefined,
				page: 1,
				size: 15,
				sort: 'createTime,desc',
			},
			queryParamsLabel: {
				payeeName: undefined,
				tagName: undefined,
				expenseCategoryName: undefined,
				incomeCategoryName: undefined,
				typeName: undefined,
				accountName: undefined,
				statusName: undefined,
			},
			loading: false,
			status: 'loadmore',
			loadmoreText: " ",
			showSortList: false,
			sortList: [
				{
					name: '按时间排序',
					value: 'createTime,desc'
				},
				{
					name: '按金额排序',
					value: 'amount,desc'
				}
			],
			showSearchPopup: false,
			flowTypeSearchShow: false,
			flowTypes: [
				[
					{
						id: 1,
						label: '支出'
					},
					{
						id: 2,
						label: '收入'
					},
					{
						id: 3,
						label: '转账'
					},
					{
						id: 4,
						label: '余额调整'
					}
				]
			],
			statusSearchShow: false,
			flowStatus: [
				[
					{
						id: 1,
						label: '正常'
					},
					{
						id: 2,
						label: '待确认'
					},
					{
						id: 3,
						label: '已退款'
					}
				]
			]
		}
	},
	onLoad: async function() {
		if (!this.$store.getters.user) this.$store.dispatch('getSession');
		if (!this.$store.getters.enablePayees) this.$store.dispatch('getEnablePayees');
		if (!this.$store.getters.enableTags) this.$store.dispatch('getEnableTags');
		if (!this.$store.getters.expenseCategories) this.$store.dispatch('getExpenseCategories');
		if (!this.$store.getters.incomeCategories) this.$store.dispatch('getIncomeCategories');
		if (!this.$store.getters.enableAccounts) this.$store.dispatch('getEnableAccounts');
		
		await this.fetchData();
		
		var $this = this;
		this.$eventBus.$on('flowsUpdated', function() {
			$this.refreshData();
		});
		
	},
	async onReachBottom() {
		if (this.status === 'loadmore') {
			await this.fetchData(true);
		}
	},
	async onPullDownRefresh() {
		await this.refreshData();
		uni.stopPullDownRefresh();
	},
	methods: {
		async refreshData() {
			this.flows = [];
			this.queryParams = {
				page: 1,
				size: 15,
				sort: 'createTime,desc',
			};
			this.queryParamsLabel = { },
			this.status = 'loadmore';
			await this.fetchData();
		},
		async fetchData(isMore) {
			if (!isMore) this.loading = true;
			if (isMore) this.status = 'loading';
			try{
				const response = await queryFlows(this.queryParams);
				if (response.result.content.length === 0) {
					if (!isMore) {
						this.status = 'empty';
					} else {
						this.status = 'nomore';
					}
				} else {
					this.flows = [...this.flows, ...response.result.content];
					if (response.result.content.length < this.queryParams.size) {
						this.status = 'nomore';
					} else {
						this.queryParams.page = this.queryParams.page + 1;
						this.status = 'loadmore';
					}
				}
				this.loading = false;
			} catch(e) {
				this.loading = false;
				console.log(e);
			}
		},
		itemClick(item) {
			var $this = this;
			uni.navigateTo({
				url: '/pages/flow-detail/flow-detail?id=' + item.id,
				events: {
					deleteSuccess() {
						$this.refreshData();
					}
				}
			});
		},
		showSortAction() {
			this.showSortList = true;
		},
		closeSortAction() {
			this.showSortList = false;
		},
		sortItemClick(item) {
			this.queryParams.sort = item.value;
			this.showSortList = false;
			this.refreshData();
		},
		showSearchModal() {
			this.showSearchPopup = true;
		},
		closeSearchPopup() {
			this.showSearchPopup = false;
		},
		openPayeeSelect() {
			this.$store.commit('setSelectList', this.$store.getters.enablePayees);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择交易对象&value=' + this.queryParams.payees,
				events: {
					selectedValue(n) {
						that.queryParams.payees = n;
						that.queryParamsLabel.payeeName = that.$store.getters.enablePayees.find(e => e.id === n).name;
					}
				}
			});
		},
		openTagSelect() {
			this.$store.commit('setSelectList', this.$store.getters.enableTags);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择标签&value=' + this.queryParams.tags,
				events: {
					selectedValue(n) {
						that.queryParams.tags = n;
						that.queryParamsLabel.tagName = that.$store.getters.enableTags.find(e => e.id === n).name;
					}
				}
			});
		},
		openExpenseCategorySelect() {
			this.$store.commit('setSelectList', this.$store.getters.expenseCategories);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择支出分类&value=' + this.queryParams.categories,
				events: {
					selectedValue(n) {
						that.queryParams.categories = n;
						that.queryParamsLabel.expenseCategoryName = that.$store.getters.expenseCategories.find(e => e.id === n).name;
					}
				}
			});
		},
		openIncomeCategorySelect() {
			this.$store.commit('setSelectList', this.$store.getters.incomeCategories);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择收入分类&value=' + this.queryParams.categories,
				events: {
					selectedValue(n) {
						that.queryParams.categories = n;
						that.queryParamsLabel.incomeCategoryName = that.$store.getters.incomeCategories.find(e => e.id === n).name;
					}
				}
			});
		},
		openFlowTypeSelect() {
			this.flowTypeSearchShow = true;
		},
		openAccountSelect() {
			this.$store.commit('setSelectList', this.$store.getters.enableAccounts);
			var that = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择账户&value=' + this.queryParams.accountId,
				events: {
					selectedValue(n) {
						that.queryParams.accountId = n;
						that.queryParamsLabel.accountName = that.$store.getters.enableAccounts.find(e => e.id === n).name;
					}
				}
			});
		},
		confirmFlowType(e) {
			this.queryParams.type = e.value[0].id;
			this.queryParamsLabel.typeName = e.value[0].label;
			this.flowTypeSearchShow = false;
		},
		closeFlowType() {
			this.flowTypeSearchShow = false;
		},
		openFlowStatusSelect() {
			this.statusSearchShow = true;
		},
		confirmFlowStatus(e) {
			this.queryParams.status = e.value[0].id;
			this.queryParamsLabel.statusName = e.value[0].label;
			this.statusSearchShow = false;
		},
		closeFlowStatus() {
			this.statusSearchShow = false;
		},
		async queryFlowsSubmit() {
			this.closeSearchPopup();
			this.flows = [];
			this.queryParams.page = 1;
			this.queryParams.size = 15;
			this.status = 'loadmore';
			await this.fetchData();
		},
		queryFlowsReset() {
			this.queryParams.description = undefined;
			this.queryParams.minTime = undefined;
			this.queryParams.maxTime = undefined;
			this.queryParams.payees = undefined;
			this.queryParams.tags = undefined;
			this.queryParams.categories = undefined;
			this.queryParams.type = undefined;
			this.queryParamsLabel = { };
		}
	}
}
</script>

<style lang="scss">
.u-nav-slot {
	@include flex;
	margin-right: 90px;
	align-items: center;
	justify-content: space-between;
	border-width: 0.5px;
	border-radius: 100px;
	border-color: $u-border-color;
	padding: 3px 7px;
	gap: 10px;
}
.query-form {
	padding: 30px 10px;
}
</style>
