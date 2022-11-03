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
			</view>
		</u-navbar>
		<u-tabs :list="tabList" @click="tabClick" :scrollable="false"></u-tabs>
		<uni-list :border="true">
			<uni-list-item v-for="(item, index) in accounts" :key="index" clickable
				:title="item.name"
				:rightText="item.balanceFormatted"
				link @click="itemClick(item)">
			</uni-list-item>
		</uni-list>
		<u-loadmore :status="status" :loadmoreText="loadmoreText" />
		<u-loading-page :loading="loading"></u-loading-page>
		<tab-bar :selectedIndex="0"></tab-bar>
		<u-action-sheet
			:actions="sortList"
			:show="showSortList"
			:closeOnClickOverlay="true"
			@select="sortItemClick"
			@close="closeSortAction">
		</u-action-sheet>
	</view>
</template>

<script>
import { queryAccounts } from '@/config/api.js';
export default {
	data() {
		return {
			tabList: [
				{ name: '活期' },
				{ name: '信用' },
				{ name: '贷款' },
				{ name: '资产' },
			],
			currentIndex: 0,
			accounts: [ ],
			queryParams: {
				page: 1,
				size: 15,
				sort: 'id,desc',
			},
			loading: false,
			status: 'loadmore',
			loadmoreText: " ",
			showSortList: false,
			sortList: [
				{
					name: '余额排序',
					value: 'balance,desc'
				},
				{
					name: '可用优先',
					value: 'enable,desc'
				},
				{
					name: '支出优先',
					value: 'expenseable,desc'
				},
				{
					name: '收入优先',
					value: 'incomeable,desc'
				}
			]
		}
	},
	onLoad: async function() {
		if (!this.$store.getters.user) this.$store.dispatch('getSession');
		await this.fetchData();
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
			this.accounts = [];
			this.queryParams.page = 1;
			this.status = 'loadmore';
			await this.fetchData();
		},
		async fetchData(isMore) {
			if (!isMore) this.loading = true;
			if (isMore) this.status = 'loading';
			try {
				const response = await queryAccounts(this.currentIndex + 1, this.queryParams);
				if (response.content.length === 0) {
					this.status = 'nomore';
				} else {
					this.accounts = [...this.accounts, ...response.content];
					if (response.content.length < this.queryParams.size) {
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
		tabClick(item) {
			this.currentIndex = item.index;
			this.refreshData();
		},
		itemClick(item) {
			var $this = this;
			uni.navigateTo({
				url: '/pages/account-detail/account-detail?id=' + item.id,
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
</style>
