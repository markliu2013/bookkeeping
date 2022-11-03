<template>
	<view>
		<u-tabs v-if="formType === 1" :list="tabList" @click="tabClick" :scrollable="false"></u-tabs>
		<expense-form v-if="tabIndex === 0"></expense-form>
		<income-form v-else-if="tabIndex === 1"></income-form>
		<transfer-form v-else-if="tabIndex === 2"></transfer-form>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				tabList: [
					{ name: '支出' },
					{ name: '收入' },
					{ name: '转账' },
				],
				currentIndex: 0,
			}
		},
		methods: {
			tabClick(item) {
				this.currentIndex = item.index;
			}
		},
		computed: {
			tabIndex() {
				const formType = this.$store.getters['modelForm/type'];
				const flowType = this.$store.getters['modelForm/model'].type;
				if (formType === 1) {
					return this.currentIndex;
				} else {
					return flowType - 1;
				}
			},
			formType() {
				return this.$store.getters['modelForm/type'];
			},
			title() {
				const formType = this.$store.getters['modelForm/type'];
				const flowType = this.$store.getters['modelForm/model'].type;
				if (formType === 1) {
					return "新增流水";
				} else if (formType === 2) {
					if (flowType === 1) {
						return "修改支出";
					} else if (flowType === 2) {
						return "修改收入";
					} else if (flowType === 3) {
						return "修改转账";
					}
				} else if (formType === 3) {
					if (flowType === 1) {
						return "复制支出";
					} else if (flowType === 2) {
						return "复制收入";
					} else if (flowType === 3) {
						return "复制转账";
					}
				} else if (formType === 4) {
					if (flowType === 1) {
						return "退款支出";
					} else if (flowType === 2) {
						return "退款收入";
					} else if (flowType === 3) {
						return "退款转账";
					}
				}
			}
		},
		onLoad(option) {
			uni.setNavigationBarTitle({ title: this.title });
		},
	}
</script>

<style>

</style>
