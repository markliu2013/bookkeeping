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
				<u-icon name="search" size="25"></u-icon>
			</view>
		</u-navbar>
		<u-list @scrolltolower="scrolltolower" :showScrollbar="true">
			<u-list-item v-for="(item, index) in flows" :key="index">
				<u-cell
				    :title="item.title"
				    :value="item.amountFormatted"
				    :label="item.subTitle"
					:isLink="true" arrow-direction="right"
					@click="itemClick(item)"
				></u-cell>
			</u-list-item>
			<u-loadmore :status="status" :loadmoreText="loadmoreText" />
		</u-list>
		<u-loading-page :loading="loading"></u-loading-page>
	</view>
</template>

<script>
import { queryFlows } from '@/config/api.js';
export default {
	data() {
		return {
			flows: [],
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
	created() {
		var $this = this;
		this.$eventBus.$on('flowsUpdated', function() {
			$this.refreshData();
		});
	},
	methods: {
		async scrolltolower() {
			await this.fetchData(true);
		},
		async refreshData() {
			this.flows = [];
			this.queryParams.page = 1;
			this.status = 'loadmore';
			await this.fetchData();
		},
		async fetchData(isMore) {
			if (!isMore) this.loading = true;
			if (isMore) this.status = 'loading';
			try{
				const response = await queryFlows(this.queryParams);
				if (response.result.content.length === 0) {
					this.status = 'nomore';
				} else {
					this.flows = [...this.flows, ...response.result.content];
					this.queryParams.page = this.queryParams.page + 1;
					this.status = 'loadmore';
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
</style>