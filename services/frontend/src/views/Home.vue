<script setup>
	import { defineComponent } from 'vue'
	import axios from 'axios'
</script>

<template>
<div class="authorization-panel">
	<div class="title">
		<img alt="Vue logo" class="logo" src="../assets/logo.svg" width="32" height="32" />
		<h1>Test App</h1>
	</div>
	<div v-if="form.hasError" class="error">
		<p>Unable to authenticate. Please check your credentials and try again</p>
	</div>
	<form @submit.prevent="handleAuth">
		<div>
			<label for="username">Username:</label>
			<input type="text" name="username" v-model="form.username" />
		</div>
		<div>
			<label for="password">Password:</label>
			<input type="password" name="password" v-model="form.password" />
		</div>
		<button type="submit">Sign In</button>
	</form>
</div>
</template>

<script>
export default defineComponent({
	name: 'Home',
	data() {
		return {
			form: {
				username: '',
				password: '',
				hasError: false
			}
		};
	},
	methods: {
		async handleAuth() {
			this.form.hasError = false
			const {username, password} = this.form
			if (username === '' || password === '') {
				this.form.hasError = true
			}
  			try {
    			const response = await axios.post(
					'/token', 
					new URLSearchParams({ username, password }),
					{
      					headers: {
        					'Content-Type': 'application/x-www-form-urlencoded'
      					},
						withCredentials: true
    				})

    			const token = response.data.access_token
    			localStorage.setItem('token', token)

    			axios.defaults.headers.common['Authorization'] = `Bearer ${token}`

				this.$router.push('/dashboard')
  			} catch (err) {
    			console.error('Login failed:', err)
				this.form.hasError = true
  			}
		}
	}
})
</script>

<style scoped>
.authorization-panel {
	display: flex;
	flex-direction: column;
	width: 100%;
	max-width: 400px;
	margin: 0 auto;
}
.error {
	border: 1px solid red;
	border-radius: 4px;
	margin-bottom: 8px;
	padding: 12px 24px;
	font-size: 14px;
	line-height: 1.2;
}
.title {
	display: flex;
	align-items: center;
	gap: 12px;
	text-align: center;
	margin-bottom: 12px;
}
form > div {
	display: flex;
	flex-direction: column;
	margin-bottom: 8px;
}
form input {
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
form button {
	padding: 8px;
	background-color: #333;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 100px;
}
</style>
