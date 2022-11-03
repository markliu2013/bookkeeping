<template>
	<view class="u-page">
		<u-navbar
			:safeAreaInsetTop="true"
			:placeholder="true"
			:border="true"
			leftIcon="reload"
			leftIconSize="25px"
			@leftClick="refreshData()"
		>
			<view class="u-nav-slot" slot="right">
				<u-icon name="list" size="25"></u-icon>
				<u-icon name="plus" size="25"></u-icon>
			</view>
		</u-navbar>
		<u-tabs :list="tabList" @click="tabClick" :scrollable="false"></u-tabs>
		<!-- <u-list @scrolltolower="scrolltolower" :showScrollbar="true">
			<u-list-item v-for="(item, index) in accounts" :key="index">
				<u-cell
				    :title="item.name"
				    :value="item.balanceFormatted"
					:isLink="true" arrow-direction="right"
					@click="itemClick(item)"
				></u-cell>
			</u-list-item>
			<u-loadmore :status="status" :loadmoreText="loadmoreText" />
		</u-list> -->
		<uni-list>
			<uni-list-item v-for="(item, index) in accounts" :key="index" clickable
				:title="item.name"
				:rightText="item.balanceFormatted"
				link @click="itemClick(item)">
			</uni-list-item>
		</uni-list>
		<u-loading-page :loading="loading"></u-loading-page>
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
				size: 15
			},
			loading: false,
			status: 'loadmore',
			loadmoreText: " ",
		}
	},
	mounted: async function() {
		await this.fetchData();
	},
	methods: {
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
		async scrolltolower() {
			await this.fetchData(true);
		},
		async refreshData() {
			this.accounts = [];
			this.queryParams.page = 1;
			this.status = 'loadmore';
			await this.fetchData();
		},
		async fetchData(isMore) {
			if (!isMore) this.loading = true;
			if (isMore) this.status = 'loading';
			try{
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