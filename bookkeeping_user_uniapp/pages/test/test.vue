<template>
	<view>
		<u-navbar
			:safeAreaInsetTop="true"
			:placeholder="true"
			:border="true"
			:fixed="true"
			leftIcon="reload"
			leftIconSize="25px"
		>
			<view class="u-nav-slot" slot="right">
				<u-icon name="list" size="25"></u-icon>
				<u-icon name="plus" size="25"></u-icon>
			</view>
		</u-navbar>
		
		<uni-list>
			<uni-list-item  title="列表文字" ></uni-list-item>
			<uni-list-item :disabled="true" title="列表禁用状态" ></uni-list-item>
		</uni-list>
		
		
		<u-tabbar
			:value="selectedIndex"
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
		data() {
			return {
				selectedIndex: 0,
				indexList: [],
				urls: [
					'https://cdn.uviewui.com/uview/album/1.jpg',
					'https://cdn.uviewui.com/uview/album/2.jpg',
					'https://cdn.uviewui.com/uview/album/3.jpg',
					'https://cdn.uviewui.com/uview/album/4.jpg',
					'https://cdn.uviewui.com/uview/album/5.jpg',
					'https://cdn.uviewui.com/uview/album/6.jpg',
					'https://cdn.uviewui.com/uview/album/7.jpg',
					'https://cdn.uviewui.com/uview/album/8.jpg',
					'https://cdn.uviewui.com/uview/album/9.jpg',
					'https://cdn.uviewui.com/uview/album/10.jpg',
				]
			}
		},
		onLoad() {
			this.loadmore()
		},
		methods: {
			scrolltolower() {
				this.loadmore()
			},
			loadmore() {
				for (let i = 0; i < 30; i++) {
					this.indexList.push({
						url: this.urls[uni.$u.random(0, this.urls.length - 1)]
					})
				}
			}
		},
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
