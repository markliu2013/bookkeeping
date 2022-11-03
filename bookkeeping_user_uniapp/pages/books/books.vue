<template>
	<view class="u-page">
		<uni-list :border="true">
			<uni-list-item v-for="(item, index) in books" :key="index"
				:title="item.name"
				:note="item.notes">
				<template v-slot:footer>
					<u-button
						@click="setDefault(item)"
						text="设为默认"
						type="success"
						size="mini"
						:disabled="defaultBook.id === item.id"
						:customStyle="{width: 'auto'}"
					></u-button>
				</template>
			</uni-list-item>
		</uni-list>
		<u-loadmore v-if="status !== 'empty'" :status="status" :loadmoreText="loadmoreText" />
		<u-loading-page :loading="loading"></u-loading-page>
	</view>
</template>

<script>
import { queryBooks, setDefaultBook } from '@/config/api.js';
export default {
	data() {
		return {
			books: [ ],
			queryParams: {
				page: 1,
				size: 15,
			},
			loading: false,
			status: 'loadmore',
			loadmoreText: " ",
			setDefaultLoading: false
		}
	},
	computed: {
		defaultBook() {
			return this.$store.getters['defaultBook'];
		}
	},
	mounted: async function() {
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
			this.books = [];
			this.queryParams = {
				page: 1,
				size: 15,
			};
			this.status = 'loadmore';
			await this.fetchData();
		},
		async fetchData(isMore) {
			if (!isMore) this.loading = true;
			if (isMore) this.status = 'loading';
			try {
				const response = await queryBooks(this.queryParams);
				if (response.content.length === 0) {
					if (!isMore) {
						this.status = 'empty';
					} else {
						this.status = 'nomore';
					}
				} else {
					this.books = [...this.books, ...response.content];
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
		async setDefault(item) {
			if (this.setDefaultLoading === true) return;
			this.setDefaultLoading = true;
			try {
				await setDefaultBook(item.id);
				uni.$u.toast('操作成功');
				this.setDefaultLoading = false;
				this.$store.dispatch('getSession');
				await this.refreshData();
			} catch(e) {
				this.setDefaultLoading = false;
				console.log(e);
			}
		}
	},
}
</script>

<style>

</style>
