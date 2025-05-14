<script setup>
	import axios from 'axios';
	import { defineComponent } from 'vue'
	import Navbar from '../components/Navbar.vue'
</script>

<template>
	<Navbar />
	<div>
		<h1>Welcome to the Dashboard</h1>
		<p>Data on the last login in the admin area</p>
		<table v-if="logs.length > 0">
		<thead>
			<tr>
				<th>Login Time</th>
				<th>Username</th>
				<th>Name</th>
				<th>User Agent</th>
			</tr>
		</thead>
		<tbody>
		<tr v-for="log in logs" :key="log.id">
			<td>{{ log.login_time }}</td>
			<td>{{ log.username }}</td>
			<td>{{ log.name }}</td>
			<td>{{ log.user_agent }}</td>
		</tr>
		</tbody>
		</table>
		<p v-else>No login logs found.</p>
	</div>
</template>

<script>
export default defineComponent({
	name: 'Dashboard',
	data() {
		return {
			logs: []
		};
	},
	mounted: async function() {
		try {
			const response = await axios.get('/loginlogs', {
				headers: {
					Authorization: `Bearer ${localStorage.getItem('token')}`
				}
			});
			if(response.data.length > 0) {
				console.log('Login logs:', response.data);
				this.logs = response.data;
			} else {
				console.log('No login logs found.');
			}
		} catch (error) {
			console.error('Error fetching login logs:', error);
		}
	}
})
</script>

<style scoped>
  h1, p {
    text-align: center;
  }
  table {
	margin: 12px auto;
	border-collapse: collapse;
	width: 80%;
	font-size: 14px;
  }
  th, td {
	border: 1px solid #ddd;
	padding: 4px;
	text-align: left;
  }
  th {
	background-color: #eee;
	font-weight: bold;
  }
</style>
