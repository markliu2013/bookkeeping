<template>
	<view class="u-page">
		<u-navbar
			title="我的"
			leftIcon=" "
			:safeAreaInsetTop="true"
			:placeholder="true"
			:border="true"
			:fixed="true">
		</u-navbar>
		<uni-list>
			<uni-list-item title="用户名" :rightText="user && user.userName" />
			<uni-list-item title="会员到期日" :rightText="user && vipTime" />
			<uni-list-item title="当前组" :rightText="defaultGroup && defaultGroup.name" />
			<uni-list-item title="当前账本" :rightText="defaultBook && defaultBook.name" />
		</uni-list>
		
		<uni-list :border="false" style="margin-top: 20px;">
			<uni-list-item title="账本管理" clickable link @click="openBooks" />
			<uni-list-item title="当前版本号" rightText="1.0.1" />
		</uni-list>
		<view class="u-content">
			<u-button type="primary" @click="logout" text="退出登录" :customStyle="{marginTop: '15px'}"></u-button>
		</view>
		<tab-bar :selectedIndex="3"></tab-bar>
	</view>
	
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		computed: {
			user() {
				return this.$store.getters['user'];
			},
			vipTime() {
				return uni.$u.timeFormat(new Date(this.	user.vipTime), 'yyyy-mm-dd')
			},
			defaultGroup() {
				return this.$store.getters['defaultGroup'];
			},
			defaultBook() {
				return this.$store.getters['defaultBook'];
			}
		},
		onLoad: function() {
			if (!this.$store.getters.user) this.$store.dispatch('getSession');
		},
		methods: {
			logout() {
				uni.removeStorageSync('userToken');
				uni.reLaunch({ url: '/pages/login/login' });
			},
			openBooks() {
				uni.navigateTo({ url: '/pages/books/books' });
			}
		},
	}
</script>

<style>

</style>
