<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style lang="scss">
	/*每个页面公共css */
	@import "@/uni_modules/uview-ui/index.scss";
	.u-tabbar__content__item-wrapper {
		align-items: center !important;
	}
	.u-content {
		padding: 0 10px;
	}
	.uni-list-item__extra-text {
		font-size: 16px !important;
	}
	.expense .uni-list-item__extra-text {
		color: #3c9cff !important;
	}
	.income .uni-list-item__extra-text {
		color: #ff0000 !important;
	}
</style>
