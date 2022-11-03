<template>
	<view class="u-content">
		<u-search v-model="keyword" @change="keywordChange" :showAction="false" :customStyle="{margin: '15px 0'}"></u-search>
		<u-checkbox-group v-if="multiple" v-model="checkboxValue" placement="row" size="22">
			<u-checkbox
				:customStyle="{marginBottom: '10px'}"
				v-for="item in list"
				:key="item.id"
				:label="item.name"
				:name="item.id"
			>
			</u-checkbox>
		</u-checkbox-group>
		<u-radio-group v-else placement="row" size="22" @change="radioGroupChange" v-model="radioValue">
			<u-radio
				:customStyle="{marginBottom: '10px'}"
				v-for="item in list"
				:key="item.id"
				:label="item.name"
				:name="item.id"
			>
			</u-radio>
		</u-radio-group>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				radioValue: undefined,
				multiple: false,
				keyword: '',
				checkboxValue: []
			}
		},
		computed: {
			list() {
				return this.$store.getters.selectList.filter(e => e.name.indexOf(this.keyword) >= 0)
			}
		},
		methods: {
			radioGroupChange(n) {
				const eventChannel = this.getOpenerEventChannel();
				eventChannel.emit('selectedValue', n);
				uni.navigateBack();
			},
		},
		onLoad(option) {
			uni.setNavigationBarTitle({ title: option.title });
			this.multiple = option.multiple;
			if (this.multiple) {
				this.checkboxValue = option.value.split(',').map(e => parseInt(e));
			} else {
				this.radioValue = parseInt(option.value);
			}
			
		},
		onUnload() {
			if (this.multiple) {
				const eventChannel = this.getOpenerEventChannel();
				eventChannel.emit('selectedValue', this.checkboxValue);
			}
		}
	}
</script>

<style>
.u-radio-group--row, .u-checkbox-group--row {
	flex-wrap: wrap !important;
	gap: 10px !important;
}
</style>
