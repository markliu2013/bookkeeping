<template>
	<view class="u-page">
		<image class="logo" src="/static/logo.png"></image>
		<u--form labelWidth="60" :model="form" :rules="rules" ref="uForm">
			<u-form-item label="用户名" prop="userName">
				<u--input v-model="form.userName"></u--input>
			</u-form-item>
			<u-form-item label="密码" prop="password">
				<u--input type="password" v-model="form.password"></u--input>
			</u-form-item>
			<u-form-item label="API地址" prop="apiUrl">
				<u--input v-model="form.apiUrl"></u--input>
			</u-form-item>
		</u--form>
		<u-button type="primary" @click="submit" :loading="loading" text="提交"></u-button>
	</view>
</template>

<script>
	import { signin } from '@/config/api.js';
	export default {
		data() {
			return {
				form: {
					userName: '',
					password: '',
					apiUrl: 'https://testjz.jiukuaitech.com/api/v1/'
				},
				loading: false,
				rules: {
					'userName': {
						type: 'string',
						required: true,
						message: '请输入用户名',
						trigger: ['blur', 'change']
					},
					'password': {
						type: 'string',
						required: true,
						message: '请输入密码',
						trigger: ['blur', 'change']
					},
					'apiUrl': {
						type: 'string',
						required: true,
						message: '请输入API地址',
						trigger: ['blur', 'change']
					},
				}
			}
		},
		computed: {
			
		},
		methods: {
			async submit() {
				try {
					this.loading = true;
					await this.$refs.uForm.validate();
					const $this = this;
					uni.$u.http.setConfig((config) => {
						config.baseURL = $this.form.apiUrl;
						return config;
					});
					this.$store.commit('updateApiUrl', $this.form.apiUrl);
					const data = await signin(this.form);
					this.$store.commit('updateToken', data.token);
					uni.$u.toast('登录成功');
					this.loading = false;
					uni.redirectTo({ url: '/pages/flows/flows' });
				} catch (e) {
					this.loading = false;
					console.log(e);
				}
			}
		},
		onReady() {
			// 如果需要兼容微信小程序，并且校验规则中含有方法等，只能通过setRules方法设置规则
			this.$refs.uForm.setRules(this.rules)
		},
	}
</script>

<style>
	.u-page {
		padding: 0 15px;
	}
	.logo {
		display: block;
		margin: 200rpx auto 50rpx auto;
		height: 200rpx;
		width: 200rpx;
	}
</style>
