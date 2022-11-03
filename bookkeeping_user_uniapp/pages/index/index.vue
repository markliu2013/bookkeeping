<template>
	<view>
		<u-loading-page :loading="true"></u-loading-page>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		onLoad: function() {
			if (uni.getStorageSync('userToken')) {
				uni.reLaunch({ url: '/pages/flows/flows' });
			} else {
				uni.reLaunch({ url: '/pages/login/login' });
			}
		},
		methods: {
			
		}
	}
</script>

<style lang="scss">
	
</style>
