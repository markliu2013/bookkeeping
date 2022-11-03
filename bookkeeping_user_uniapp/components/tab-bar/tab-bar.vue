<template>
	<view>
		<u-tabbar
			:value="selectedIndex"
			@change="tabChange"
			:fixed="true"
			:placeholder="true">
			<u-tabbar-item text="账户" icon="home"></u-tabbar-item>
			<u-tabbar-item text="流水" icon="list-dot"></u-tabbar-item>
			<u-button type="primary" text="记账" shape="circle" @click="addFlow"></u-button>
			<u-tabbar-item text="图表" icon="eye"></u-tabbar-item>
			<u-tabbar-item text="我的" icon="account"></u-tabbar-item>
		</u-tabbar>
	</view>
</template>

<script>
	export default {
		props: {
			selectedIndex: {
				type: Number,
				required: true
			}
		},
		methods: {
			tabChange(value) {
				switch (value) {
					case 0:
						uni.reLaunch({ url: '/pages/accounts/accounts' });
						break;
					case 1:
						uni.reLaunch({ url: '/pages/flows/flows' });
						break;
					case 2:
						uni.reLaunch({ url: '/pages/charts/charts' });
						break;
					case 3:
						uni.reLaunch({ url: '/pages/my/my' });
						break;
				}
			},
			addFlow() {
				//不能在navigateTo的success回调执行，否则微信小程序第一次加载是空白
				this.$store.commit('modelForm/setType', 1);
				this.$store.commit('modelForm/setModel', { });
				uni.navigateTo({ url: '/pages/flow-form/flow-form' });
			}
		}
	}
</script>

<style>

</style>