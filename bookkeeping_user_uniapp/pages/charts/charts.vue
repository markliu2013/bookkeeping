<template>
	<view>
		<u-navbar
			:safeAreaInsetTop="true"
			:placeholder="true"
			:border="true"
			:fixed="true"
			leftIcon="reload"
			leftIconSize="25px"
			@leftClick="fetchData"
		>
			<view class="u-nav-slot" slot="right">
				<u-icon name="search" size="25" @click="showSearchModal"></u-icon>
			</view>
		</u-navbar>
		<u-tabs :list="tabList" @click="tabClick" :scrollable="false" :customStyle="{marginBottom: '20px'}"></u-tabs>
		<qiun-data-charts 
			type="ring"
			:opts="opts"
			:chartData="chartData"
			:canvas2d="true"
		/>
		<uni-list :border="true" :customStyle="{marginTop: '20px'}">
			<uni-list-item v-for="(item, index) in xyList" :key="index"
				:title="item.x"
				:note="item.y.toFixed(2)"
				:rightText="item.percent+'%'"
			>
			</uni-list-item>
		</uni-list>
		<u-loading-page :loading="loading"></u-loading-page>
		<tab-bar :selectedIndex="2"></tab-bar>
		<u-popup
			:show="showSearchPopup"
			mode="top"
			:closeOnClickOverlay="true"
			:safeAreaInsetTop="true"
			@close="closeSearchPopup"
			:customStyle="{background: '#fff'}"
		>
			<view class="query-form">
				<u--form :model="queryParams" labelWidth="auto">
					<u-form-item label="开始时间：" borderBottom>
						<uni-datetime-picker v-model="queryParams.minTime" type="date" :border="false" return-type="timestamp" />
					</u-form-item>
					<u-form-item label="结束时间：" borderBottom>
						<uni-datetime-picker v-model="queryParams.maxTime" type="date" :border="false" return-type="timestamp" />
					</u-form-item>
					<u-form-item label="分类：" borderBottom @click="openCategorySelect">
						<u--input v-model="queryParamsLabel.categoryName" disabled disabledColor="#ffffff" placeholder="请选择分类" border="none"></u--input>
						<u-icon slot="right" name="arrow-right"></u-icon>
					</u-form-item>
				</u--form>
				<u-button type="primary" @click="querySubmit" text="查询" :customStyle="{marginTop: '15px'}"></u-button>
				<u-button @click="closeSearchPopup" text="关闭" :customStyle="{marginTop: '15px'}"></u-button>
			</view>
		</u-popup>
	</view>
</template>

<script>
import { reportExpenseCategory, reportIncomeCategory, reportDebt, reportAsset  } from '@/config/api.js';
export default {
	data() {
		return {
			tabList: [
				{ name: '支出分类' },
				{ name: '收入分类' },
				{ name: '资产分类' },
				{ name: '负债分类' },
			],
			currentIndex: 0,
			loading: false,
			xyList: [ ],
			queryParams: {
				minTime: new Date(new Date().setDate(new Date().getDate() - 30)).getTime(),
				maxTime: new Date().getTime(),
				categoryId: undefined,
			},
			queryParamsLabel: {
				categoryName: undefined,
			},
			searchDisable: false,
			showSearchPopup: false,
		};
	},
	computed: {
		chartData() {
			const seriesData = this.xyList.map(e => {
				return {
					"name": e.x,
					"value": e.y
				}
			});
			const chartData = {
				series: [
				  {
					data: seriesData
				  }
				]
			};
			return JSON.parse(JSON.stringify(chartData));
		},
		opts() {
			let totalAmount = 0;
			this.xyList.forEach(i => {
				totalAmount += i.y*100;
			});
			totalAmount = (totalAmount / 100).toFixed(2);
			return {
				legend: {
					position: 'bottom',
					margin: 10,
				},
				title: {
					name: "总金额",
					fontSize: 12,
					color: "#666666"
				},
				subtitle: {
					name: totalAmount,
					fontSize: 18,
					color: "#7cb5ec"
				},
				extra: {
					ring: {
						ringWidth: 20
					},
					
				},
			}
		}
	},
	onLoad: async function() {
		if (!this.$store.getters.expenseCategories) this.$store.dispatch('getExpenseCategories');
		if (!this.$store.getters.incomeCategories) this.$store.dispatch('getIncomeCategories');
		await this.fetchData();
	},
	methods: {
		async tabClick(item) {
			this.currentIndex = item.index;
			this.queryReset();
			if (this.currentIndex === 2 || this.currentIndex === 3) {
				this.searchDisable = true;
			} else {
				this.searchDisable = false;
			}
			await this.fetchData();
		},
		async fetchData() {
			try {
				this.loading = true;
				if (this.currentIndex === 0) {
					this.xyList = await reportExpenseCategory(this.queryParams);
				} else if (this.currentIndex === 1) {
					this.xyList = await reportIncomeCategory(this.queryParams);
				} else if (this.currentIndex === 2) {
					this.xyList = await reportAsset();
				} else if (this.currentIndex === 3) {
					this.xyList = await reportDebt();
				}
				this.loading = false;
			} catch(e) {
				this.loading = false;
				console.log(e);
			}
		},
		showSearchModal() {
			if (this.searchDisable === true) {
				return false;
			}
			this.showSearchPopup = true;
		},
		closeSearchPopup() {
			this.showSearchPopup = false;
		},
		openCategorySelect() {
			if (this.currentIndex === 0) {
				this.$store.commit('setSelectList', this.$store.getters.expenseCategories);
			} else {
				this.$store.commit('setSelectList', this.$store.getters.incomeCategories);
			}
			var $this = this;
			uni.navigateTo({
				url: '/pages/select/select?title=选择分类&value=' + this.queryParams.categoryId,
				events: {
					selectedValue(n) {
						$this.queryParams.categoryId = n;
						if ($this.currentIndex === 0) {
							$this.queryParamsLabel.categoryName = $this.$store.getters.expenseCategories.find(e => e.id === n).name;
						} else {
							$this.queryParamsLabel.categoryName = $this.$store.getters.incomeCategories.find(e => e.id === n).name;
						}
					}
				}
			});
		},
		async querySubmit() {
			this.closeSearchPopup();
			await this.fetchData();
		},
		queryReset() {
			this.queryParams.minTime = new Date(new Date().setDate(new Date().getDate() - 30)).getTime();
			this.queryParams.maxTime = new Date().getTime();
			this.queryParams.categoryId = undefined;
			this.queryParamsLabel.categoryName = undefined;
		}
	}
};
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