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
			uni.$u.http.setConfig((config) => {
				config.baseURL = uni.getStorageSync('apiUrl');
				return config;
			});
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
